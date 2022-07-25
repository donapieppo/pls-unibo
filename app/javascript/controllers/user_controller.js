import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'roleInput', 'otherStringDiv', 'schoolChoose', 'seats' ]

  connect() {
    console.log("user controller");
    this.show_and_hide();
    this.roleInputTarget.addEventListener('change', () => {
      this.show_and_hide()
    })
  }

  show_and_hide(event) {
    var selectedRole = this.roleInputTarget.querySelectorAll('input:checked')[0];

    if (selectedRole && (selectedRole.value === 'other' || selectedRole.value == 'student_university')) {  
      this.schoolChooseTarget.style.display = 'none';
      this.otherStringDivTarget.style.display = 'block';
      if (this.hasSeatsTarget) {
        this.seatsTarget.style.display = 'none';
      }
    } else {
      this.otherStringDivTarget.querySelector('textarea').value = '';
      this.otherStringDivTarget.style.display = 'none';
      this.schoolChooseTarget.style.display = 'block';
      if (selectedRole && selectedRole.value === 'teacher' && this.hasSeatsTarget) {
        this.seatsTarget.style.display = 'block';
      }
    }
  }
}
