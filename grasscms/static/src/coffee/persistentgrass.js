// Generated by CoffeeScript 1.3.3
(function() {
  var PersistentGrass;

  PersistentGrass = (function() {

    function PersistentGrass(element_, options) {
      this.element_ = element_;
      this.options = $.extend({}, options);
      this.element = $(this.element_);
      this.init();
    }

    PersistentGrass.prototype.init = function() {
      this.do_resizable();
      return this.assign_events();
    };

    PersistentGrass.prototype.do_resizable = function() {
      this.element.data("width", this.element.css('width'));
      this.element.data("height", this.element.css('height'));
      return this.element = (($(this.element_)).wrap('<div class="resizable" data-offset="' + this.options.offset + '">')).parent();
    };

    PersistentGrass.prototype.assign_events = function() {
      var opt, _i, _len, _ref, _results;
      _ref = ['clear', 'mouseover', 'drag', 'mouseout', 'dblclick', 'contextmenu', 'dragstart', 'dragend', 'click', 'changed'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        opt = _ref[_i];
        _results.push(this.element.on(opt, this[opt]));
      }
      return _results;
    };

    PersistentGrass.prototype.click = function(ev) {
      var div, id, img, source, target, target_child, text;
      target = $(ev.target);
      target_child = ($(ev.target)).children()[0];
      id = ($(target)).attr('id');
      if (!id && ($(target_child)).attr('id')) {
        id = ($(target_child)).attr('id');
      }
      if (!id) {
        return;
      }
      $('#panel_left')[0].dataset['current_element'] = id;
      if (getCurrentElement().css('opacity')) {
        $('#opacitypicker').val(getCurrentElement().css('opacity'));
      } else {
        $('#opacitypicker').val(1);
      }
      img = ($(target)).children('img');
      div = ($(target)).children('div');
      if (img[0]) {
        source = ((($(target)).children('img')).attr('src')).split('/');
        text = source[source.length - 1];
      } else if (div[0]) {
        text = "Text element";
      }
      return ($('#current_element_name')).html(text);
    };

    PersistentGrass.prototype.dblclick = function(ev) {
      var target;
      target = $(ev.target);
      if (!target.hasClass('textGrassy')) {
        return;
      }
      target.attr('contentEditable', 'true');
      target.attr('draggable', 'false');
      target.addClass('editor_active');
      ($('#editor')).show();
      return ($('#toggle_editing')).hide();
    };

    PersistentGrass.prototype.clear = function() {
      ($('#panel_left')).dataset['current_element'] = false;
      return ($('#current_element_name')).html("GrassCMS");
    };

    PersistentGrass.prototype.mouseover = function() {
      return ($(this)).toggleClass('selectedObject');
    };

    PersistentGrass.prototype.contextmenu = function(ev) {
      ($('#menu'))[0].dataset['currentTarget'] = $(ev.target).attr('id');
      ($('#menu')).css('top', ev.y - 35);
      ($('#menu')).css('left', ev.x - 300);
      ($('#menu')).show();
      return false;
    };

    PersistentGrass.prototype.mouseout = function() {
      var elem;
      ($(this)).toggleClass('selectedObject');
      if (($(this)).attr('id')) {
        elem = $(this);
      } else {
        if (!($(($(this)).children[0])).attr('id')) {
          return;
        }
        elem = $(($(this)).children[0]);
      }
      if (elem.css('height' !== elem.data('height'))) {
        elem.trigger('changed', 'height', this.style.height);
        elem.data('height', elem.css('height'));
      }
      if (elem.css('width' !== elem[0].dataset['width'])) {
        elem.trigger('changed', 'width', this.style.width);
        return elem.data('width', elem.css('width'));
      }
    };

    PersistentGrass.prototype.dragstart = function(ev) {
      $(this).trigger('click');
      this.dataset['opacity'] = this.style.opacity ? this.style.opacity : 1;
      return this.style.opacity = 0.4;
    };

    PersistentGrass.prototype.drag = function(ev) {
      this.style.opacity = this.dataset['opacity'] > 0 ? this.dataset['opacity'] : 1;
      if (ev.x > this.dataset['offset']) {
        this.style.left = ev.x - this.dataset['offset'] + "px";
      }
      this.style.top = ev.y + "px";
      return this.style.position = "absolute";
    };

    PersistentGrass.prototype.dragend = function(ev) {
      this.style.opacity = this.dataset['opacity'] > 0 ? this.dataset['opacity'] : 1;
      $(this).trigger('changed', 'top', ev.y);
      return $(this).trigger('changed', 'left', ev.x);
    };

    PersistentGrass.prototype.changed = function(attr, result) {
      var id;
      return;
      id = $(this).attr('id');
      return $.ajax('/object/', {
        type: 'PUT',
        dataType: 'json',
        data: JSON.stringify({
          'id': id,
          'attr': attr,
          'result': result
        })
      });
    };

    return PersistentGrass;

  })();

  (function($) {
    return $.fn.PersistentGrass = function(options) {
      var grasspersistence;
      if (options == null) {
        options = {
          offset: 250
        };
      }
      return grasspersistence = new PersistentGrass(this, options);
    };
  })($);

}).call(this);
