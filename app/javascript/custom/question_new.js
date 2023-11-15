$(document).load('turbolinks:load', function(){
  $('.add-new-question').on('click', function(e) {
    e.preventDefault()
    $(this).addClass('hidden')
    $('.new_question').removeClass('hidden')
  })
})