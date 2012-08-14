from grasscms.models import Blog, Page, Html
from grasscms.converters import *
from grasscms.objects import *
from werkzeug import secure_filename
import json, os
from flask.ext.login import (LoginManager, current_user, login_required,
                             login_user, logout_user, UserMixin, AnonymousUser,
                             confirm_login, fresh_login_required)


app.jinja_env.filters['html'] = render_html
object_base = Objects()
login_manager = LoginManager()
login_manager.setup_app(app)

class DbUser(object):
    """Wraps User object for Flask-Login"""
    def __init__(self, user):
        self._user = user

    def get_id(self):
        return unicode(self._user.id)

    def is_active(self):
        return True

    def is_anonymous(self):
        return False

    def is_authenticated(self):
        return True

@login_manager.user_loader
def load_user(user_id):
    user = User.query.get(user_id)
    if user:
        return DbUser(user)
    else:
        return None

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    next = request.args.get('next')
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(username=username).first()
        if user.password == password:
            if login_user(DbUser(user)):
                flash("You have logged in")
                return redirect(next or url_for('index', error=error))
        error = "Login failed"
    return render_template('login.html', login=True, next=next, error=error)

def save_file(file_):
    file_secure_name = secure_filename(file_.filename)
    path = get_path(file_secure_name)
    file_.save(path)
    return (file_secure_name, path)

def get_element_by_id(id_):
    return Html.query.filter_by(id_=id_, user=g.user.id).first()

def get_page_by_id(name, id_=0):
    return Page.query.filter_by(name=name, id_=id_).first()

def get_path(filename):
    return os.path.join(os.path.join(app.config['UPLOAD_FOLDER'], str(g.user.id) ), filename)

def check_user():
    if g.user:
        user_blog = Blog.query.filter_by(id=g.user.blog).first()
        user_page = Page.query.filter_by(id=g.user.index).first() if g.user else ""
    else:
        user_page = False
        user_blog = False
    return (user_blog, user_page)

@app.route("/upload/<page>", methods=("GET", "POST"), subdomain="<subdomain>")
def upload_(page, subdomain=False):
    object_base = Objects()
    for i in request.files.keys():
        filename, path = save_file(request.files[i])
        try:
            field_name, content = do_conversion(filename, path, app.config['STATIC_ROOT'], g.user.id)
            app.logger.info(content)
            result = getattr(object_base, field_name)(page, content)
        except Exception, error:
            flash('Error file, unsupported format, reason: %s' %(error))
            app.logger.info(error)
            return ""
        if not result:
            result = ""
        return result
    return render_template("upload.html", filedata="", page=page, blog=blog)

@app.route('/image/edit', subdomain="<subdomain>")
def svgedit(subdomain=False):
    user_page, user_blog = check_user()
    return render_template('svg-editor.html', page=request.args.get('page'))

@app.route('/page-admin/<page>', subdomain="<subdomain>")
def pageadmin(page=False, subdomain=False):
    user_page, user_blog = check_user()
    if g.user:
        main_url = "http://" + user_blog.subdomain + "." +\
         app.config['SERVER_NAME']
    else:
        main_url = "http://grasscms.com"
    return render_template('pages.html', main_url=main_url, page=user_page,
        blog=user_blog)

@app.route('/')
def landing():
    user_blog, user_page = check_user()
    if g.user:
        main_url = "http://" + user_blog.subdomain + "." +\
        app.config['SERVER_NAME']
    else:
        main_url = 'http://landing.' + app.config['SERVER_NAME']
    return redirect(main_url)

@app.route('/<page_>', subdomain='<blog_name>')
@app.route('/<page_>/<subpage>', subdomain='<blog_name>')
@app.route('/', subdomain='<blog_name>')
def page(blog_name=False, page_="index", subpage=0, main_url=False):
    if blog_name == "www" and not g.user:
        return redirect('http://landing.' + app.config['SERVER_NAME'])
    blog_name = blog_name.lower()
    user_blog, user_page = check_user()
    try:
        blog = Blog.query.filter_by(subdomain=blog_name).first()
        page = Page.query.filter_by(blog=blog.id, name=page_, id_=subpage).first()
        app.logger.info(page)
        if not page:
            page = Page.query.filter_by(name=page_, blog=blog.id).first()
    except AttributeError, error:
        app.logger.info(error)

    if not blog:
        return render_template('start_your_blog.html',
            url = app.config['SERVER_NAME'])
    elif not page:
        abort(404)

    if g.user:
        main_url = "http://" + user_blog.subdomain + "." + \
        app.config['SERVER_NAME']

    if blog == user_blog and g.user:
        g.user_is_admin = True

    static_htmls = Html.query.filter_by(blog=blog.id, page=page.id)

    # In a future, each page must have a full title.
    title = page.name
    paid_user = blog.paid_this_month

    if title == "index":
        title = blog.name
    paid_user = blog.paid_this_month

    if not g.user_is_admin:
        return render_template( 'index.html', main_url=main_url, page=page,
            blog=user_blog, static_htmls=static_htmls,
            description=blog.description, title=title, paid_user = paid_user)
    else:
        return render_template( 'admin.html', main_url=main_url, page=page,
            blog=user_blog, static_htmls=static_htmls, title=title,
            first_run=request.args.get('first_run'))

@app.route('/object/<type_>/', methods=['PUT', 'DELETE', 'GET', 'POST'], subdomain="<subdomain>")
def object_manager(type_, subdomain=False):
    id = request.form['id']

    if id == "undefined":
        abort(404)

    if method == "GET" or method == "PUT":
        try:
            page, subpage = json.loads(request.form['page'])
            if not subpage:
                subpage = 0
            element = get_page_by_id(name_, id_)
        except KeyError:
            element = get_element_by_id(id)

    if method == "POST":
        try:
            result = request.form['result']
        except KeyError, err:
            result = type_
        try:
            page = request.form['page']
        except KeyError, err:
            page = "index"
        return getattr(object_base, type_)(page, result)

    elif method == "DELETE":
        if type_ == "page":
            blog = Blog.query.filter_by(id=g.user.blog).first()
            page = Page.query.filter_by(name=id, blog=blog.id).first()
            if page:
                db_session.delete(page)
                db_session.commit()
            else:
                abort(404)
            return "true"

        object_ = Html.query.filter_by(id_=id_).first();
        db_session.delete(object_)
        db_session.commit()
        return json.dumps("True")

    elif method == "GET":
        try:
            attr=request.form['attr']
            return json.dumps(getattr(element, attr))
        except KeyError:
            return json.dumps(element) # TODO: Nope.

    elif method == "PUT":
        try:
            attr=request.form['attr']
            data=request.form['result']
        except KeyError:
            return json.dumps("False")

        try:
            setattr(element, attr, data)
            db_session.commit()
            return json.dumps(getattr(element, data))
        except Exception, error:
            app.logger.info(error)
            return "False"

@app.route('/set/<what>/<id_>/<result>', methods=['GET', 'POST'], subdomain="<subdomain>")
def set(what, id_, result, subdomain=False):
    element = get_element_by_id(id_)
    if result == "in_post":
        result="<div class='handler'></div>\
           <textarea class='alsoResizable'>%s</textarea>" %(request.form['result'])
    try:
        setattr(element, what, result)
        db_session.commit()
        return json.dumps(getattr(element, what))
    except Exception, error:
        app.logger.info(error)
        return "False"
