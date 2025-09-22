import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="title-blink"
export default class extends Controller {
  static values = {
    newTitle: String
  }

  connect() {
    let newTitle = this.newTitleValue
    let oldTitle = document.title

    let blink = () => {
      document.title = document.title == newTitle ? oldTitle : newTitle
    }

    this.blinkInterval = setInterval(blink, 1000)
  }

  disconnect() {
    clearInterval(this.blinkInterval)
  }
}
