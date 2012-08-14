# Requires base.coffee to be compiled with this.

assign_input_events_to_object = (element) ->
  element.on event, changed_input for event in [ 'input', 'change', 'blur']

assign_toolbar_events = ->
  assign_input_events_to_object(($ element)) for element in [ '#top', '#left', '#width', '#height']

changed_input = (ev)->
  ($ getCurrentElement().parent()).css this.id, this.value

update_toolbar = (target) ->
  ($ '#width') .val ((target .css 'width') .split ('px'))[0]
  ($ '#height') .val ((target .css 'height') .split ('px'))[0]
  ($ '#top') .val ((target .css 'top') .split ('px'))[0]
  ($ '#left') .val ((target .css 'left') .split ('px'))[0]

setup_toolbar = (toolbar) ->
  ($ '#opacitypicker').on 'change', ->
    if getCurrentElement()
      getCurrentElement().css 'opacity', $('#opacitypicker').val()

  ($ '#colorpicker').on 'change', ->
    if getCurrentElement()
      getCurrentElement().css 'background', $('#colorpicker').val()
    else
      $('body').css 'background', $('#colorpicker').val()

  ($ '#cssclasses').on 'change', ->
    ($ getCurrentElement()).addClass class_ for class_ in  this.value.split(',')
    ($ getCurrentElement()).trigger 'changed', [ 'cssclasses', this.value ]

window.changed=changed_input
