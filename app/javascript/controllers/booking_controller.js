import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['bookableboolean', 'by', 'for', 'dates', 'url', 'inpresence', 'online']

  connect() {
    console.log("booking controller");

    display_unless(['no', 'external'], this.byTarget, this.bookablebooleanTarget;
    display_unless(['no', 'external'], this.forTarget, this.bookablebooleanTarget;

    display_unless('no', this.datesTarget, document.getElementById('edition_bookable'));
    display_if('external', this.urlTarget, document.getElementById('edition_bookable'));
    //display_if_checked(document.getElementById('if_in_presence'), document.getElementById('edition_in_presence'));
    //display_if_checked(document.getElementById('if_online'), document.getElementById('edition_online'));
  }
}
