contextual_menu = (target, menu_position) ->
  ($ '#menu')[0] .dataset['currentTarget'] = $(target).attr('id')
  ($ '#menu') .css 'top', menu_position[1] - 35
  ($ '#menu') .css 'left', menu_position[0] - 30
  ($ '#menu') .show()
  return false

setup_menu = (target) ->
  ($ target).on 'click', (ev) ->
    if ev.button == 0 and ev.target.parentNode.id != "#menu"
      $('#menu').css("display", "none")
