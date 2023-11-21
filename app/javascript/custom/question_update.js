$(document).load('turbolinks:load', function(){
  $('.question').on('click', '.edit-question-link', function(e) {
    e.preventDefault()
    $(this).addClass('hidden');
    var questionId = $(this).data('questionId')
    $('form#edit-question-' + questionId).removeClass('hidden')
  })
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
