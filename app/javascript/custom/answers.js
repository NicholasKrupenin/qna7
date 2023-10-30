$(document).load('turbolinks:load', function(){
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault()
    $(this).toggle('hidden')
    var answerId = $(this).data('answerId')
    $('form#edit-answer-' + answerId).toggle('hidden')
  })
})
