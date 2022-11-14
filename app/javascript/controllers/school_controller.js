import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'province', 'school' ]
  // select_in_province_schools_path
  static values = { url: String }

  connect() {
    console.log(`school controller with url: ${this.urlValue}`);
  }

  change_province() {
    var province = this.provinceTarget.value;
    var frame = document.getElementById('school_options');

    console.log(`school_controller: change province to ${province}`);
    frame.src = this.urlValue + '?p=' + province;
    frame.reload();
  }
}
