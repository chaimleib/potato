$(function() {
    $('input.datetimepicker').datetimepicker();
    $('input.datepicker').datetimepicker({
        format: 'MM/DD/YYYY',
    });

    $('table.table').bootstrapTable({ /* options */
        onAll: function (data) {
            $('time.timeago').timeago();
        }
    });
});

