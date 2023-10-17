// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'controllers'

import jquery from "jquery"
window.jQuery = jquery
window.$ = jquery

import "@nathanvda/cocoon"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

import Rails from '@rails/ujs'
Rails.start()


$(document).load('turbolinks:load', function(){
    if ($('.answers').length) {
      $('.answers').on('click', '.edit-answer-link', function(e) {
        e.preventDefault()
        $(this).hide()
        var answerId = $(this).data('answerId')
        $('form#edit-answer-' + answerId).removeClass('hidden')
      })
    } else if ($('.question').length) {
    $('.question').on('click', '.edit-question-link', function(e) {
      e.preventDefault()
      $(this).hide()
      var questionId = $(this).data('questionId')
      $('form#edit-question-' + questionId).removeClass('hidden')
    })
  }
})
