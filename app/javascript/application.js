// Entry point for the build script in your package.json
// import "@hotwired/turbo-rails"
// import "./controllers"

import Rails from "@rails/ujs"
Rails.start()

import "trix"
import "@rails/actiontext"

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

