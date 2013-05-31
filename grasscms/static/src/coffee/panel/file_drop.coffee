drop = (ev) ->
  files = ev.dataTransfer.files
  reader = new FileReader()
  console.log(files[0])
  console.log(reader)
  reader.onload = (evt) ->
    # TODO: This has to be uploaded to the server, get the cb, and put the cb.
    img = ($ '<img>')
    img .attr 'src', evt.target.result
    img .addClass 'persistentGrassy'
    ($ 'body') .append img
    ($ img) .PersistentGrass()
  reader.readAsDataURL(files[0])
  stoppropagation(ev)

stoppropagation = (ev) ->
  ev.preventDefault()
  ev.stopPropagation()

($ '#filediv').on 'drop', drop
($ '#filediv').on 'dragenter', stoppropagation
($ '#filediv').on 'dragover', stoppropagation
($ '#filediv').on 'dragexit', stoppropagation

