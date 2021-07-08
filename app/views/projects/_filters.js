const year_selector = document.getElementById('years');
const audience_selector = document.getElementById('audiences');
const area_selector = document.getElementById('areas');
const activity_type_selector = document.getElementById('activity_types');

const hide_projects_not_selected = () => {
  document.querySelectorAll('.project').forEach ((p) => { p.style.display = 'block' });

  [year_selector, audience_selector, area_selector, activity_type_selector].forEach((selector) => {
    var checked_ids = Array.prototype.map.call(selector.querySelectorAll('input:checked'), (x) => parseInt(x.value));
    console.log(selector.id);
    console.log(checked_ids);
    if (checked_ids.length > 0) {
      document.querySelectorAll('.project').forEach( (p) => {
        var ids_in_project = p.getAttribute(`data-${selector.id}`);
        // console.log(p);
        // console.log(ids_in_project);
        // if intersection of checked_ids and ids_in_project empty => hide
        if (checked_ids.filter(x => ids_in_project.includes(x)).length === 0) {
          p.style.display = 'none';
        }
      });
    };
  });
};

[year_selector, audience_selector, area_selector, activity_type_selector].forEach( (selector) => {
  selector.addEventListener('change', () => {
    console.log(selector.id + " changed");
    hide_projects_not_selected();
  });
});

