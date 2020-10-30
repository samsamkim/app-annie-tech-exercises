$(document).on('turbolinks:load', function() {

  // Initializing datatables and datepicker and set default date
  $('#connections-table').DataTable({
    paging: true
  });
  $('.datepicker').datepicker({
    dateFormat: 'dd/mm/yy',
  });
  $('#start_date').datepicker('setDate', new Date(Date.now() - 86400000));
  $('#end_date').datepicker('setDate', new Date());

  // Checkbox change sends ajax call
  $('.checkboxes').change(function() {
    postToConnectionFilter();
  });

  // Datepicker change sends ajax call
  $('.datepicker').change(function(){
    postToConnectionFilter();
  });

  // Function for ajax
  function postToConnectionFilter() {
    var checked_attributes = [];
    $('.checkboxes:checked').each(function(){
      checked_attributes.push($(this).attr('id'));
    });
    var start_date = $('#start_date').val();
    var end_date = $('#end_date').val();

    $.ajax({
      type: 'POST',
      url: 'connections_filter.js',
      data: {
        checked_attributes: checked_attributes.toString(), 
        start_date: start_date, 
        end_date: end_date
      },
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
