import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  toggle(e) {
    // const hideAndShow = e.currentTarget.querySelector('.resource_container_resources');
    const hideAndShow = e.currentTarget.nextElementSibling;
    if (hideAndShow) {
      hideAndShow.classList.toggle('hidden');
    }
  }
}

