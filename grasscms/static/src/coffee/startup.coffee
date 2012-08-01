# Contextual menu and other stuff that have to be done outside too, or not.

($ document).ready ->
  ($ document).on 'click', (ev) ->
    if ev.button == 0 and ev.target.parentNode.id != "#menu"
      $('#menu').css("display", "none")

  ($ '#opacitypicker').on 'change', ->
    if getCurrentElement()
      getCurrentElement().css 'opacity', $('#opacitypicker').val()

  ($ '#colorpicker').on 'change', ->
    if $('#panel_left').data('current_element')
      getCurrentElement().css 'background', $('#colorpicker').val()
    else
      $('body').css 'background', $('#colorpicker').val()

  ($ '.persistentGrassy') .PersistentGrass()
  ($ '.rect-x') .Ruler('x')
  ($ '.rect-y') .Ruler('y')
