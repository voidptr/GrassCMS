# Requires base.coffee to be compiled with this.

assign_toolbar_events = ->
  ($ '#y').on 'input', changed_input
  ($ '#y').on 'change', changed_input
  ($ '#y').on 'blur', changed_input

changed_input = (ev)->
  console.log this
  console.log "foo"

update_toolbar = (target) ->
  ($ '#width') .val ((target .css 'width') .split ('px'))[0]
  ($ '#height') .val ((target .css 'height') .split ('px'))[0]
  ($ '#y') .val ((target .css 'top') .split ('px'))[0]
  ($ '#x') .val ((target .css 'left') .split ('px'))[0]

setup_toolbar = (toolbar) ->
  ($ '#opacitypicker').on 'change', ->
    if getCurrentElement()
      getCurrentElement().css 'opacity', $('#opacitypicker').val()

  ($ '#colorpicker').on 'change', ->
    if $('#panel_left').data('current_element')
      getCurrentElement().css 'background', $('#colorpicker').val()
    else
      $('body').css 'background', $('#colorpicker').val()

window.changed=changed_input
