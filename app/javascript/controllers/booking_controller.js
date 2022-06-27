import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("booking controller");

    display_unless(['no', 'external'], document.getElementById('bookable_by_div'), document.getElementById('edition_bookable'));
    display_unless(['no', 'external'], document.getElementById('bookable_for_div'), document.getElementById('edition_bookable'));

    display_unless('no', document.getElementById('booking_dates'), document.getElementById('edition_bookable'));
    display_if('external', document.getElementById('booking_url'), document.getElementById('edition_bookable'));
    display_if_checked(document.getElementById('if_in_presence'), document.getElementById('edition_in_presence'));
    display_if_checked(document.getElementById('if_online'), document.getElementById('edition_online'));
  }
}
