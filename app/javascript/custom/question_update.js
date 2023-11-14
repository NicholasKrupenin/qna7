$(document).load('turbolinks:load', function(){
  $('.question').on('click', '.edit-question-link', function(e) {
    e.preventDefault()
    $(this).addClass('hidden');
    var questionId = $(this).data('questionId')
    $('form#edit-question-' + questionId).removeClass('hidden')
  })
})
