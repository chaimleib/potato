(function() {
  var root;

  root = this;

  $(document).on('page:change', function() {
    var due_date_due;
    $('#wiki-btn').mouseup(function() {
      $(this).attr('disabled', 'disabled');
      $(root.potato.elements.throbber()).insertAfter(this);
      return $('#mass-update-form').submit();
    });
    due_date_due = $('#due_date_due').val();
    $('#due_date_due').change(function() {
      due_date_due = $('#due_date_due').val();
      $("#due_date_due_ref_id").val('');
      return false;
    });
    $('#due_date_due_ref_id').change(function() {
      if ($('#due_date_due_ref_id').val()) {
        due_date_due = $("#due_date_due").val();
        $("#due_date_due").val('');
        $("#due_date_due").attr('disabled', 'disabled');
      } else {
        $("#due_date_due").val(due_date_due);
        $("#due_date_due").removeAttr('disabled');
      }
      return false;
    });
    if ($('#due_date_due_ref_id').val()) {
      $("#due_date_due").val('');
      return $("#due_date_due").attr('disabled', 'disabled');
    }
  });

}).call(this);
