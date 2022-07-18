import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "resource" ];

  connect() {
    console.log("Resource");
  }

  show_resources(event) {
    var type = event.params['type'];
    console.log(`show_resources: ${type}`);

    this.resourceTargets.forEach ((resource) => { 
      if (resource.getAttribute(`data-type`) === type) {
        resource.style.display = 'block';
      } else {
        resource.style.display = 'none';
      }
    });
  };
}

