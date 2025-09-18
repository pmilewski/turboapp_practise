import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autosubmit"
export default class extends Controller {
  static targets = ["submitButton"]
  static values = { immediately: Boolean }


  connect() {
    console.log("Autosubmit controller connected")
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.hidden = true
    }
  }

  submit() {
    if (this.immediatelyValue) {
      this.submitButtonTarget.click()
      return
    }

    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.submitButtonTarget.click()
    }, 500)
  }
}
