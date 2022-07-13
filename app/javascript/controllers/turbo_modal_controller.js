import { Controller } from "@hotwired/stimulus"

class TurboModalController extends Controller {
  static targets = ["modalContent"]

  connect() {
    console.log("turbo modal connected");
  }

  showModal() {
    console.log("SHOW MODAL");
  }

  hideModal() {
    console.log("hideModal MODAL")
    // Without this, turbo won't re-open the modal on subsequent clicks
    this.element.parentElement.removeAttribute("src")
    this.element.remove()
  }

  // hide modal on successful form submission
  // action: "turbo:submit-end->turbo-modal#submitEnd"
  // https://turbo.hotwired.dev/reference/events
  submitEnd(e) {
    console.log("Submit Modal");
    if (e.detail.success) {
      this.hideModal()
    }
  }

  followLink(e) {
    console.log("Follow link");
    this.hideModal()
    console.log(e.detail.url);
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

  closeBackground(e) {
    if (e && this.modalContentTarget.contains(e.target)) {
      return
    }
    this.hideModal()
  }
}

export { TurboModalController as default };
