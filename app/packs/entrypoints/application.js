// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"

require("trix")
require("@rails/actiontext")

Rails.start()
// ActiveStorage.start()

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

window.display_unless_no = function (what, condition_input) {
  what.style.display = (condition_input.value == 'no') ? 'none' : 'block';
  condition_input.addEventListener('change', () => {
    console.log(condition_input.value);
    booking_dates.style.display = (condition_input.value === 'no') ? 'none' : 'block';
  });
}

window.show_contact = function (e) {
  var modal = document.getElementById('main-modal');
  var header = `<h2 class="my-2">${e.name} ${e.surname}</h2><hr/>`;
  var content = `
  <div>
    <div class="my-2">${e.affiliation}</div>
    <div class="my-4">
    <div><a href="mailto:${e.email}">${e.email}</a></div>
    <div><a href="${e.web_page}">${e.web_page}</a></div>
    <div class="my-4 ml-4 italic text-gray-700">${e.description}</div>
  </div>
    `;
  document.getElementById('main-modal-header').innerHTML = header;
  document.getElementById('main-modal-body').innerHTML = content;
  modal.style.display = 'block';

  modal.addEventListener('click', () => {
    document.getElementById('main-modal').style.display = 'none';
  })

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
}
