# Functions that might be used outside the plugin
stoppropagation = (evt) ->
  evt.stopPropagation()
  evt.preventDefault()

recover_mobility = () ->
  element = getCurrentElement()
  ($ element) .attr 'draggable', true
  ($ element) .removeClass 'editor_active'

setCss = (param, value, element, parent)  ->
  element = $('#' + element) # We're getting element as an id
  curr_value = (Number) ($ element) .css param
  if curr_value == "auto" or not curr_value
    curr_value = 0
  if value == "-1"
    value = curr_value + 1
  if value == "+1"
    value = curr_value + 1
  ($ element) .css param, value
  if parent
    $(element).parent().css param, value
  $(element).trigger 'changed', param, value

getFromMenu = (element) ->
  return $(element).parent().parent()[0].dataset['currentTarget']

delete_ = (element, parent=False) ->
  $(element).trigger 'changed', 'delete'
  $(element).trigger 'clear'
  if parent
    $('#' + element).parent().remove()
  $('#' + element).remove()

getCurrentElement = () ->
  return $('#' + $('#panel_left')[0].dataset['current_element'])

stoppropagation = (ev) ->
    ev.preventDefault()
    ev.stopPropagation()

# Exports
window.stopPropagation = stoppropagation
window.getCurrentElement = getCurrentElement
window.delete_ = delete_
window.setCss=setCss
window.recover_mobility = recover_mobility
window.getFromMenu = getFromMenu
window.drop = drop

