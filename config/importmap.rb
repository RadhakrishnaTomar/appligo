# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "tabler", to: "https://cdn.jsdelivr.net/npm/@tabler/core@1.0.0-beta16/dist/js/tabler.min.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.3/dist/jquery.js"
pin "admin", to: "admin.js", preload: true
pin "bootstrap.bundle", to: "bootstrap.bundle.js", preload: true
