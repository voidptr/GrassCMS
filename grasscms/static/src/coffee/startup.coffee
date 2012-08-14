# Contextual menu and other stuff that have to be done outside too, or not.

($ document).ready ->
  setup_menu(document)
  setup_toolbar('body')
  assign_toolbar_events()
  ($ document).on 'dragover', dragover
  $('#page_editor').children(":not(.no-drag)").Sortable()
  ($ '#editor') .simpleHtml5Editor()
  ($ '.persistentGrassy') .PersistentGrass()
  ($ '.rect-x') .Ruler('x')
  ($ '.rect-y') .Ruler('y')
