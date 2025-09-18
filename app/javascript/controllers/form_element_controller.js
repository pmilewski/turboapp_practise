import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-element"
export default class extends Controller {
  static targets = ["submitBtn"]

  connect() {
  }

  remoteSubmit() {
    this.submitBtnTarget.click()
  }
}
