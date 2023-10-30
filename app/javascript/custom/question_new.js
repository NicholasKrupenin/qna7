$(document).load('turbolinks:load', function(){
  $('.add-new-question').on('click', function(e) {
    e.preventDefault()
    $(this).toggle('hidden')
    $('.new_question').toggle('hidden')
  })
})