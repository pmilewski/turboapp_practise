import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener('click', this.handleClick.bind(this))
  }

  handleClick(event) {
    if (event.target.tagName === 'A') {
      this.onNavClick(event.target)
    }
  }

  onNavClick(link) {
    console.log('Link clicked:', link.textContent.trim())
    let videoEl = document.querySelector('video')
    if (videoEl) {
      document.querySelector('video').requestPictureInPicture()
    }
  }
}

