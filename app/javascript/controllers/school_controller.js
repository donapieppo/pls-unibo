import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'province', 'school' ]

  connect() {
    console.log("school controller");
    this.provinceTarget.addEventListener('change', (e) => {
      var province = e.target.value;
      console.log(e.target)
      this.schoolTarget.value = "0"
      console.log(`province changed -> ${province}`)
      this.schoolTarget.querySelectorAll("option").forEach((i) => {
        if (i.dataset.province == province) {
          i.style.display = 'block'
        } else {
          i.style.display = 'none'
        }
      })
    })
  }
}
