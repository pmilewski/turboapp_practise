import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autosubmit"
export default class extends Controller {
  static targets = ["submitButton"]

  connect() {
    console.log("Autosubmit controller connected")
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.hidden = true
    }
  }

  submit() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.submitButtonTarget.click()
    }, 500)
  }
}
