import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['bookableType', 'by', 'for', 'dates', 'url', 'inpresence', 'online']

  connect() {
    console.log("booking controller");

    display_unless(['no', 'external'], this.byTarget, this.bookableTypeTarget);
    display_unless(['no', 'external'], this.forTarget, this.bookableTypeTarget);

    display_unless('no', this.datesTarget, this.bookableTypeTarget);
    display_if('external', this.urlTarget, this.bookableTypeTarget);
    //display_if_checked(document.getElementById('if_in_presence'), document.getElementById('edition_in_presence'));
    //display_if_checked(document.getElementById('if_online'), document.getElementById('edition_online'));
  }
}