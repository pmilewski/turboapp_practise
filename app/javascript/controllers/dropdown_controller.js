import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["dropdownContent", "openButton", "closeButton", "active"]
  static values = { open: Boolean }
  static classes = ["opened"]

  connect() {
    this.openValue
      ? this.openDropdown()
      : this.closeDropdown()

    console.log("controller dropdown connected")
  }

  toggleDropdown() {
    this.dropdownContentTarget.hidden
      ? this.openDropdown()
      : this.closeDropdown()
  }

  closeDropdown() {
    this.dropdownContentTarget.hidden = true
    this.activeTarget.classList.add(this.openedClass)
    try {
      this.closeButtonTarget.hidden = true
      this.openButtonTarget.hidden = false
    } catch { }
  }

  openDropdown() {
    this.dropdownContentTarget.hidden = false
    this.activeTarget.classList.remove(this.openedClass)
    try {
      this.closeButtonTarget.hidden = false
      this.openButtonTarget.hidden = true
    } catch { }
  }
}
