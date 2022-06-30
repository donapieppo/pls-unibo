import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['control', 'controlled']

  connect() {
    display_if_checked(this.controlledTarget, this.controlTarget);
  }
}

