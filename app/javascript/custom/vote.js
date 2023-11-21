$(document).load('turbolinks:load', function(){
  $('a.vote_like').ajaxSuccess(function(e) {
    $('.rating').html(e)
  })
})
