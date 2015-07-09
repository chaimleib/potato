$(function() {
    $('input.datetimepicker').datetimepicker();
    $('input.datepicker').datetimepicker({
        format: 'mm/dd/yyyy',
        todayHighlight: true,
        minView: 2,
        maxView: 3,
        daysOfWeekDisabled: [0, 6],
        bootcssVer: 3
    });

    $('table.table').bootstrapTable({ /* options */
        onAll: function (data) {
          $('time.timeago').timeago();
        }
    });
});

