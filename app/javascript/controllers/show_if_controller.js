import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-if"
export default class extends Controller {
  static targets = ["trigger", "content"]
  static values = { expected: String }

  connect() {
    this.toggle()
  }

  toggle() {
    this.contentTarget.hidden = this.triggerTarget.value != this.expectedValue
  }
}
