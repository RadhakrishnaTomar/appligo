import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {

  }

  initialize() {
    this.element.setAttribute("data-action", "click->applicant-profile#applicantProfileTab");
  }

  applicantProfileTab(event) {
    const applicantProfileId = this.element.id;
    const aplicantProfileValue = this.element.getAttribute('data-value');
    // const applicantProfileId = this.element.value;
    const activeLink = document.querySelector('.nav.nav-tabs .nav-link.active');
    if (activeLink != null) {
      activeLink.classList.remove('active');
    }

    const elementWithActiveClass = document.getElementById(applicantProfileId);
    if (elementWithActiveClass) {
      elementWithActiveClass.classList.add('active');
    }
    this.url = `applicants/applicant_profile_data?profile=${aplicantProfileValue}`
    fetch(this.url,{
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
