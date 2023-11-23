// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "tabler"
import "jquery"
import "jquery_ujs"
import $ from 'jquery'
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery