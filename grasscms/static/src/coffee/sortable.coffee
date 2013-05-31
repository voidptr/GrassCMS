class Sortable
  constructor: (@element_, options) ->
    @options = $.extend {}, options
    @element = $ @element_
    @init()

  init: ->
    @assign_events()

  assign_events: ->
    @element.on opt, this[opt] for opt in [ 'dragstart',
      'dragend', 'dragover', 'drop', 'dragenter', 'dragleave' ]

  dragover: (ev) ->
    ev.preventDefault()
    ev.dataTransfer.dropEffect = "move"
    return

  dblclick: (ev) ->

  drop: (ev) ->
    console.log window.dragSrc
    this.classList.remove('page_editor_over')
    ($ window.dragSrc).css('opacity', 1)
    window.dragSrc.innerHTML = this.innerHTML
    this.innerHTML = ev.dataTransfer.getData('text/html')
    return

  dragstart: (ev) ->
    ($ this).css('opacity', 0.2)
    ev.dataTransfer.effectAllowed = 'move'
    ev.dataTransfer.setData('text/html', this.innerHTML)
    window.dragSrc = this
    return

  dragenter: (ev) ->
    this.classList.add('page_editor_over')

  dragleave: (ev) ->
    this.classList.remove('page_editor_over')

  dragend: (ev) ->
    return

do ($) ->
  $.fn.Sortable = (options = "") ->
    sortables = ( new Sortable(elem, options) for elem in @.children())
