import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["content", "icon"]

  toggle(e) {
    e.preventDefault()
      
    // const hideAndShow = e.currentTarget.nextElementSibling;
    // if (hideAndShow) {
    //   hideAndShow.classList.toggle('hidden');
    // }

    if (this.hasContentTarget) {
      this.contentTarget.classList.toggle('hidden')
    }

    if (this.hasIconTarget) {
      this.iconTarget.classList.toggle('-rotate-90')
    }
  }
}

