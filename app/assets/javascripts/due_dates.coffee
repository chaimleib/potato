# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
root = this

$(document).on('page:change', -> # page:change is for turbolinks
  $('#wiki-btn').mouseup(() -> 
    $(this).attr('disabled', 'disabled')
    $(root.potato.throbber).insertAfter(this)
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
