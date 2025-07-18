// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//
// txts = Array
window.display_unless = function (txts, what, condition_input) {
  what.style.display = txts.includes(condition_input.value) ? 'none' : 'block';
  condition_input.addEventListener('change', () => {
    console.log(condition_input.value);
    what.style.display = txts.includes(condition_input.value) ? 'none' : 'block';
  });
}

window.display_if = function (txt, what, condition_input) {
  what.style.display = (condition_input.value == txt) ? 'block' : 'none';
  condition_input.addEventListener('change', () => {
    console.log(condition_input.value);
    what.style.display = (condition_input.value === txt) ? 'block' : 'none';
  });
}

window.display_if_checked = function (what, condition_input, display="block", negate=false) {
  if (negate) {
    what.style.display = (condition_input.checked) ? 'none' : display;
  } else {
    what.style.display = (condition_input.checked) ? display : 'none';
  }
  condition_input.addEventListener('change', () => {
    console.log(condition_input.checked);
    if (negate) {
      what.style.display = (condition_input.checked) ? 'none' : display;
    } else {
      what.style.display = (condition_input.checked) ? display : 'none';
    }
  });
}

import "trix"
import "@rails/actiontext"
