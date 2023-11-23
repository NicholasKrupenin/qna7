$(document).load('turbolinks:load', function(){
  $('.vote_like').on('ajax:success', function(e) {
    $('.rating').html(e.originalEvent.detail[0]['rating'])
  })
  $('.vote_dislike').on('ajax:success', function(e) {
    $('.rating').html(e.originalEvent.detail[0]['rating'])
  })
  $('.deselect').on('ajax:success', function(e) {
    $('.rating').html(e.originalEvent.detail[0]['rating'])
  })
})
