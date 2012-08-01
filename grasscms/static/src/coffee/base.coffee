# Functions that might be used outside the plugin

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

# Exports
window.getCurrentElement = getCurrentElement
window.delete_ = delete_
window.setCss=setCss
window.getFromMenu = getFromMenu
