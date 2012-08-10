#  Project: GrassCMS
#  Description: PersistentGrass plugin, adds capability to drag&drop objects, resize them, change css properties and automagically upload that information to a server
#  Author: David Francos Cuartero <david@theothernet.co.uk>
#  License: GPL 2+

class PersistentGrass
  constructor: (@element_, options) ->
    @options = $.extend {}, options
    @element = $ @element_
    @init()

  init: ->
    @do_resizable()
    @assign_events()

  do_resizable: ->
    @element.data  "width",  @element.css('width')
    @element.data  "height",  @element.css('height')
    @element = (($ @element_) .wrap '<div class="resizable" data-offset="' + @options.offset +  '">').parent()

  assign_events: ->
    $('.control_div') .on 'click', @clear
    @element.on opt, this[opt] for opt in ['clear', 'mouseover', 'drag',
      'mouseout', 'dblclick', 'contextmenu', 'dragstart',
      'dragend', 'click', 'changed']

  click: (ev) ->
    stopPropagation(ev)
    target = ($ ev.target)
    target_child = ($ ev.target) .children()[0]
    id = ($ target) .attr 'id'
    console.log ($ target)
    if not id  and ($ target_child) .attr 'id'
      id = ($ target_child) .attr 'id'
    if not id
     return

    ($ '.simpleHtml5Editor') .hide()
    recover_mobility()
    $('#panel_left')[0].dataset['current_element'] = id

    if getCurrentElement().css('opacity')
      $('#opacitypicker').val getCurrentElement().css('opacity')
    else
      $('#opacitypicker').val 1

    img = ($ target) .children 'img'
    div = ($ target) .children 'div'

    if img[0]
      source = ((($ target) .children 'img') .attr 'src') .split('/')
      text = source[source.length - 1]
    else if div[0]
      text = "Text element"
    else if ($ target) .is 'img'
      source = (($ target) .attr 'src') .split('/')
      text = source[source.length - 1]
    else if ($ target) .is 'div'
      text = "Text element"
    ($ '.show_on_element') .show()
    ($ '.hide_on_element') .hide()
    ($ '#current_element_name') .html text

  dblclick: (ev) ->
    stopPropagation(ev)
    target = ($ ev.target)
    return if not target .hasClass 'textGrassy'
    target .attr 'contentEditable', 'true'
    target .attr 'draggable', 'false'
    target .addClass 'editor_active'
    ($ '#editor') .show()
    ($ '#toggle_editing') .hide()

  clear: ->
    ($ '.simpleHtml5Editor') .hide()
    recover_mobility()
    ($ '#toggle_editing') .show()
    ($ '.show_on_element') .hide()
    ($ '.hide_on_element') .show()
    ($ '#current_element_name') .html("")
    ($ '#panel_left')[0] .dataset['current_element'] = false

  mouseover: (ev) ->
    stopPropagation(ev)
    ($ this).toggleClass('selectedObject')

  contextmenu: (ev) ->
      ($ '#menu')[0] .dataset['currentTarget'] = $(ev.target).attr('id')
      ($ '#menu') .css 'top', ev.y - 35
      ($ '#menu') .css 'left', ev.x - 30
      ($ '#menu') .show()
      return false

  mouseout: (ev) ->
    stopPropagation(ev)
    ($ this).toggleClass('selectedObject')

    if ($ this) .attr 'id'
      elem = ($ this)
    else
      return if not ($ ($ this) .children[0]).attr('id')
      elem= ($ ($ this).children[0])

    if elem .css 'height' != elem.data 'height'
      elem .trigger 'changed', 'height', this.style.height
      elem .data 'height', elem .css 'height'

    if elem.css 'width' != elem[0].dataset['width']
      elem.trigger 'changed', 'width', this.style.width
      elem.data 'width', elem.css 'width'

  dragstart: (ev) ->
    $(this).trigger 'click'
    this.dataset['opacity'] = if this.style.opacity then this.style.opacity else 1
    this.style.opacity = 0.4

  drag: (ev) ->
    this.style.opacity = if this.dataset['opacity'] > 0 then this.dataset['opacity'] else 1
    if ev.x > this.dataset['offset']
      this.style.left=ev.x - this.dataset['offset']  + "px"
    this.style.top=ev.y + "px"
    this.style.position = "absolute"
    stopPropagation(ev)

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
