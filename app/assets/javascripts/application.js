import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "controllers"
import "admin"
import "bootstrap.bundle"
import jquery from "jquery"
window.jQuery = jquery
window.$ = jquery

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
