# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(() ->
  getThrobber = (id) ->
    img = document.createElement('img')
    img.setAttribute('src', '/assets/throbber.gif')
    img.setAttribute('alt', 'loading...')
    img_div = document.createElement('div')
    img_div.setAttribute('id', id)
    img_div.setAttribute('class', 'icon-container')
    img_div.innerHTML = img.outerHTML
    return img_div
  throbber = getThrobber()
  $('#wiki-btn').mouseup(() -> 
    $(this).attr('disabled', 'disabled')
    $(throbber).insertAfter(this)
    $('#mass-update-form').submit()
  )

  due_date_due = $('#due_date_due').val()
  $('#due_date_due').change(->
    due_date_due = $('#due_date_due').val()
    $("#due_date_due_ref_id").val('')
    false
  )
  $('#due_date_due_ref_id').change(->
    if $('#due_date_due_ref_id').val()
      due_date_due = $("#due_date_due").val()
      $("#due_date_due").val('')
      $("#due_date_due").attr('disabled', 'disabled')
    else
      $("#due_date_due").val(due_date_due)
      $("#due_date_due").removeAttr('disabled')
    false
  )
  if $('#due_date_due_ref_id').val()
    $("#due_date_due").val('')
    $("#due_date_due").attr('disabled', 'disabled')
)
