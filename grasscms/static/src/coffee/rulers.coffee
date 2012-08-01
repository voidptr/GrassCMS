#  Project: GrassCMS
#  Description: Rulers plugin
#  Author: David Francos Cuartero <david@theothernet.co.uk>
#  License: GPL 2+
class Ruler
  constructor: (@element, movement) ->
    ($ @element) .attr "draggable", "true"
    @element[0]  .dataset['movement'] = movement
    ($ @element) .on 'dragstart', @dragstart
    ($ @element) .on 'drag', @drag
    ($ @element) .on 'dragend', @dragend

  dragstart: (ev) ->
    if this.dataset['clone'] != true
       this.dataset['clone'] = true
       el = ($ this) .clone().appendTo('body')
       el[0].dataset['clone'] = false
       ($ el) .css 'z-index', 0
       ($ this) .css 'z-index', 1
       ($ el).Ruler(this.dataset['movement'])

  drag: (ev) ->
    if this.dataset['movement'] == "x"
      if ev.x > 250
        this.style.left=ev.x + "px"
    else
      this.style.top = ev.y + "px"

  dragend: (ev) ->
    this.style.opacity = 1

do ($) ->
  $.fn.Ruler = (movement = "y") ->
    ruler = new Ruler(@, movement)
