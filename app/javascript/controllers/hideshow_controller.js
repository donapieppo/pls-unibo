import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    display: { type: String, default: "block" },
    negate: { type: Boolean, default: false }
  }
  static targets = ['control', 'controlled']

  connect() {
    console.log("displayValue: " + this.displayValue)
    console.log("negate: " + this.negateValue)
    display_if_checked(this.controlledTarget, this.controlTarget, this.displayValue, this.negateValue);
  }
}

