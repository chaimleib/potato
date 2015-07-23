(function() {
  $(document).on('page:change', function() {
    var due_date_due, getThrobber, throbber;
    getThrobber = function(id) {
      var img, img_div;
      img = document.createElement('img');
      img.setAttribute('src', '/assets/throbber.gif');
      img.setAttribute('alt', 'loading...');
      img_div = document.createElement('div');
      img_div.setAttribute('id', id);
      img_div.setAttribute('class', 'icon-container');
      img_div.innerHTML = img.outerHTML;
      return img_div;
    };
    throbber = getThrobber();
    $('#wiki-btn').mouseup(function() {
      $(this).attr('disabled', 'disabled');
      $(throbber).insertAfter(this);
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
