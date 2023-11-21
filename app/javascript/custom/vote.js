$(document).load('turbolinks:load', function(){
  $('.vote_like').on('ajax:success', function(e) {
    $('.raiting').html(e)
  })
})
