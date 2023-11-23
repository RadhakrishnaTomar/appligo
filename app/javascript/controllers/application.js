import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "controllers"
const application = Application.start()

export { application }

import Rails from "@rails/ujs";
Rails.start();
