var year_selector = document.getElementById('years');
var audience_selector = document.getElementById('audiences');
var area_selector = document.getElementById('areas');
var activity_type_selector = document.getElementById('activity_types');

function clear_filters() {
  document.querySelectorAll("#filters input[type='checkbox']").forEach((x) => x.checked = false);
  hide_projects_not_selected();
}
function toggle_filters() {
  document.getElementById("filters").classList.toggle("hidden");
}

var hide_projects_not_selected = () => {
  document.querySelectorAll('.project').forEach ((p) => { p.style.display = 'block' });
  noresults = document.getElementById('noresults');
  noresults.style.display = 'block';

  [year_selector, audience_selector, area_selector, activity_type_selector].filter(s => s !== null).forEach((selector) => {
    var checked_ids = Array.prototype.map.call(selector.querySelectorAll('input:checked'), (x) => parseInt(x.value));
    if (checked_ids.length > 0) {
      document.querySelectorAll('.project').forEach( (p) => {
        var ids_in_project = p.getAttribute(`data-${selector.id}`);
        // if intersection of checked_ids and ids_in_project empty => hide
        if (checked_ids.filter(x => ids_in_project.includes(x)).length === 0) {
          p.style.display = 'none';
        }
      });
    };
  });
  // if something visible hide noresult
  document.querySelectorAll('.project').forEach ((p) => {
    if (p.style.display == 'block') {
      noresults.style.display = 'none';
    }
  })
};

[year_selector, audience_selector, area_selector, activity_type_selector].filter(s => s !== null).forEach( (selector) => {
  selector.addEventListener('change', () => {
    console.log(selector.id + " changed");
    hide_projects_not_selected();
  });
});

