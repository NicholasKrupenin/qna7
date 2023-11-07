// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'controllers'

import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery

import '@nathanvda/cocoon'

import 'custom/answers'
import 'custom/question'
import 'custom/question_new'
import 'custom/gist_client'

import * as ActiveStorage from '@rails/activestorage'
ActiveStorage.start() 

import Rails from '@rails/ujs'
Rails.start()
