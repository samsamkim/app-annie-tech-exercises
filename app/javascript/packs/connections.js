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
    var attributes_score = {
      country: 5, app: 10, platform: 15, connection: 20
    };
    $('.checkboxes:checked').each(function(){
      checked_attributes.push($(this).attr('id'));
    });
    checked_attributes.sort(function(attr1, attr2) {
      return attributes_score[attr1] - attributes_score[attr2];
    });

    var start_date = $('#start_date').val();
    var end_date = $('#end_date').val();

    console.log(checked_attributes)
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
