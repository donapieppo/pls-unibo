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

window.display_unless = function (txt, what, condition_input) {
  what.style.display = (condition_input.value == txt) ? 'none' : 'block';
  condition_input.addEventListener('change', () => {
    console.log(condition_input.value);
    what.style.display = (condition_input.value === txt) ? 'none' : 'block';
  });
}

window.display_if = function (txt, what, condition_input) {
  what.style.display = (condition_input.value == txt) ? 'block' : 'none';
  condition_input.addEventListener('change', () => {
    console.log(condition_input.value);
    what.style.display = (condition_input.value === txt) ? 'block' : 'none';
  });
}

window.display_if_checked = function (what, condition_input) {
  what.style.display = (condition_input.checked) ? 'block' : 'none';
  condition_input.addEventListener('change', () => {
    console.log(condition_input.checked);
    what.style.display = (condition_input.checked) ? 'block' : 'none';
  });
}

