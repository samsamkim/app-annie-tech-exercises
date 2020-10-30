$(document).on("turbolinks:load", function() {
  // Initializing datatables and datepicker
  $('#connections-table').DataTable({
    paging: true
  });
  $(".datepicker").datepicker({
    dateFormat: 'dd/mm/yy'
  });

  // Checkbox change sends ajax call
  $('.checkboxes').change(function() {
    var checked_attributes = [];
    $('.checkboxes:checked').each(function(){
      checked_attributes.push($(this).attr('id'));
    });

    postToConnectionFilter({checked_attributes: checked_attributes.toString()})
  });

  // Datepicker change sends ajax call
  $('.datepicker').change(function(){
    var start_date = $('#start_date').val();
    var end_date = $('#end_date').val();

    postToConnectionFilter({start_date: start_date, end_date: end_date})
  });

  // Function for ajax
  function postToConnectionFilter(data) {
    $.ajax({
      type: 'POST',
      url: 'connections_filter.js',
      data: data,
      success(data) {
        return false;
      },
      error: function(req, status, error) {
        alert(req.responseText);
        return false;
      }
    });
  };
});
