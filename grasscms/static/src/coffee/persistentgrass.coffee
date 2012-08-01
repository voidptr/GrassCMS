#  Project: GrassCMS
#  Description: PersistentGrass plugin
#  Author: David Francos Cuartero <david@theothernet.co.uk>
#  License: GPL 2+

class PersistentGrass
  ###
   @classDescription Persistence plugin for grasscms.
  ###
  constructor: (@element_, options) ->
    @options = $.extend {}, options
    @element = $ @element_
    @init()

  init: ->
    @do_resizable()
    @assign_events()

  assign_events: ->
    @element.on 'clear', @clear_all
    @element.on 'mouseenter', @mouseenter
    @element.on 'mouseleave', @mouseleave
    @element.on 'dragstart', @dragstart
    @element.on 'drag', @drag
    @element.on 'dragend', @dragend
    @element.on 'click', @element_clicked
    @element.on 'changed', @changed
    @element.on 'contextmenu', @contextmenu

  element_clicked: (ev) ->
    first_children_id = ($ ev.target) .attr 'id'
    $('#panel_left')[0].dataset['current_element'] = first_children_id

    if getCurrentElement().css('opacity')
      $('#opacitypicker').val getCurrentElement().css('opacity')
    else
      $('#opacitypicker').val 1
    if $(this).children('img').attr('src')
      source = $(this).children('img').attr('src').split('/')
      text = source[source.length - 1]
    else if $(this).children('div')
      text = "Text element"

    if ev.shiftKey
      $($(this).children[0]).attr('contentEditable', 'true')
    $('#current_element_name').html(text)

  clear_all: ->
    ($ '#panel_left') .dataset['current_element'] = false
    ($ '#current_element_name') .html("GrassCMS")

  mouseenter: ->
    this.style.border = '1px dotted grey'

  contextmenu: (ev) ->
      ($ '#menu')[0] .dataset['currentTarget'] = $(ev.target).attr('id')
      ($ '#menu') .css 'top', ev.y - 35
      ($ '#menu') .css 'left', ev.x - 300
      ($ '#menu') .show()
      return false

  mouseleave: ->
    $($(this).children()[0]).attr('contentEditable', 'false')
    this.style.border = '0px'
    if $(this).css('height') != $(this).data('height')
      $(this).trigger 'changed', 'height', this.style.height
      $(this).dataset['height'] = $(this).css('height')
    if $(this).css('width') != $(this).data('width')
      $(this).trigger 'changed', 'width', this.style.width
      $(this).dataset['width'] = $(this).css('width')

  do_resizable: ->
    @element = @element.wrap('<div class="resizable">').parent()
    @element[0].dataset["width"] = @element.css('width')
    @element[0].dataset["height"] = @element.css('height')

  dragstart: (ev) ->
    $(this).trigger 'click'
    this.dataset['opacity'] = this.style.opacity
    this.style.border = '1px dotted grey'
    this.style.opacity = 0.4

  drag: (ev) ->
    $(this).attr 'draggable', 'true'
    this.style.opacity = if $(this).data['opacity'] > 0 then $(this).dataset['opacity'] else 1
    if ev.x > 250
      this.style.left=ev.x - 250  + "px"
    this.style.top=ev.y + "px"
    this.style.position = "absolute"

  dragend: (ev) ->
    this.style.opacity = if this.dataset['opacity'] > 0 then this.dataset['opacity'] else 1
    $(this).trigger 'changed', 'top', ev.y
    $(this).trigger 'changed', 'left', ev.x

  changed: (attr, result) ->
    return # TODO
    id = $(this).attr('id')
    $.ajax '/object/',
      type: 'PUT',
      dataType: 'json',
      data: JSON.stringify({
          'id': id,
          'attr': attr,
          'result': result
      })

do ($) ->
  $.fn.PersistentGrass = (options = offset:250) ->
    grasspersistence = new PersistentGrass(@, options)
