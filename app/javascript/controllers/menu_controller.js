import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
        static targets = ["button", "menu"]

        toggle_menu() {
                this.menuTarget.classList.toggle("active");
                this.buttonTarget.classList.toggle("active");
        }
}
