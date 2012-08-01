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
    @element.on 'mouseover', @mouseover
    @element.on 'mouseout', @mouseout
    @element.on 'dragstart', @dragstart
    @element.on 'drag', @drag
    @element.on 'dragend', @dragend
    @element.on 'click', @element_clicked
    @element.on 'changed', @changed
    @element.on 'contextmenu', @contextmenu

  element_clicked: (ev) ->
    first_children_id = ($ ev.target) .attr 'id'
    if not first_children_id and ($ ($ ev.target) .children()[0] ) .attr 'id'
      first_children_id = ($ ($ ev.target) .children[0]) .attr 'id'
    if not first_children_id
     return

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
    $('#current_element_name').html(text)

    if ev.shiftKey
      $($(this).children[0]).attr('contentEditable', 'true')

  clear_all: ->
    ($ '#panel_left') .dataset['current_element'] = false
    ($ '#current_element_name') .html("GrassCMS")

  mouseover: ->
    ($ this).toggleClass('selectedObject')

  contextmenu: (ev) ->
      ($ '#menu')[0] .dataset['currentTarget'] = $(ev.target).attr('id')
      ($ '#menu') .css 'top', ev.y - 35
      ($ '#menu') .css 'left', ev.x - 300
      ($ '#menu') .show()
      return false

  mouseout: ->
    ($ this).toggleClass('selectedObject')

    if ($ this) .attr 'id'
      elem = ($ this)
    else
      return if not ($ ($ this) .children[0]).attr('id')
      elem= ($ ($ this).children[0])

    #$($(this).children()[0]).attr('contentEditable', 'false')
    if elem .css('height') != elem[0].dataset('height')
      elem .trigger 'changed', 'height', this.style.height
      elem.dataset['height'] = elem .css('height')
    if elem.css('width') != elem[0].dataset['width']
      elem.trigger 'changed', 'width', this.style.width
      elem.dataset['width'] = elem.css('width')

  do_resizable: ->
    @element = @element.wrap('<div class="resizable">').parent()
    @element[0].dataset["width"] = @element.css('width')
    @element[0].dataset["height"] = @element.css('height')

  dragstart: (ev) ->
    $(this).trigger 'click'
    this.dataset['opacity'] = this.style.opacity
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
