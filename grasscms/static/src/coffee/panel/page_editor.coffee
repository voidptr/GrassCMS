window.dragSrc=null

class PageEditor
  constructor: (@element_, options) ->
    @options = $.extend {}, options
    @element = $ @element_
    @init()

  init: ->
    ul=($ "<ul></ul>")
    ul.html(create_li(data) for data in @options.structure)
    return ul

  create_li: (data) ->
    li = ($ '<li></li>')
    li.html('<a href=#><span onclick="this.location.href=\"/page/by_id/' + data['id'] + '\""> ' + data['name'] + ' <i class=icon-remove onclick="delete_page(' + data['id']  + ');> </i>"</a>')

  create_structure: (struct) ->
    return "foo"

do ($) ->
  $.fn.PageEditor = (options = "") ->
    page_editor = ( new PageEditor(elem, options) for elem in @.children())

