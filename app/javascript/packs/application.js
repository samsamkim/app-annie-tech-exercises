// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require('bootstrap/dist/js/bootstrap')
require('datatables.net-bs4')
require("jquery-ui")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import $ from 'jquery';
global.$ = jQuery;


$(document).on("turbolinks:load", function() {

  $('#connections-table').DataTable({
    paging: true
  });

  $(".datepicker").datepicker();


  $('.checkboxes').change(function() {
    var checked_attributes = []
    $('.checkboxes:checked').each(function(){
      checked_attributes.push($(this).attr('id'));
    })

    $.ajax({
      type: 'POST',
      url: 'connections_filter.js',
      data: {checked_attributes: checked_attributes},
      success(data) {
        console.log('success')
        return false
      },
      error(data) {
        console.log('failed')
        return false
      }
    })
  })

})
