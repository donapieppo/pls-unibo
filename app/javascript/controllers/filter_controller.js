import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "years", "areas", "audiences", "activitytypes", "noresults"]

  connect() {
    console.log("filter controller");
    this.projects = document.querySelectorAll('.with-filter');

    [this.yearsTarget, this.audiencesTarget, this.areasTarget, this.activitytypesTarget].filter(s => s !== null).forEach((selector) => {
      selector.addEventListener('change', () => {
        console.log(selector.id + " changed");
        this.hide_projects_not_selected();
      });
    });
  }

  toggle_menu() {
    this.menuTarget.classList.toggle("hidden");
  }

  clear_filters() {
    this.menuTarget.querySelectorAll("input[type='checkbox']").forEach((x) => x.checked = false);
    this.hide_projects_not_selected();
  }

  hide_projects_not_selected() {
    this.projects.forEach ((p) => { p.parentElement.style.display = 'block' });
    this.noresultsTarget.style.display = 'block';

    [this.yearsTarget, this.audiencesTarget, this.areasTarget, this.activitytypesTarget].filter(s => s !== null).forEach((selector) => {
      var checked_ids = Array.prototype.map.call(selector.querySelectorAll('input:checked'), (x) => parseInt(x.value));
      if (checked_ids.length > 0) {
        this.projects.forEach( (p) => {
          var ids_in_project = p.getAttribute(`data-${selector.id}`);
          // if intersection of checked_ids and ids_in_project empty => hide
          if (checked_ids.filter(x => ids_in_project.includes(x)).length === 0) {
            p.parentElement.style.display = 'none';
          }
        });
      };
    });

    // if something visible hide noresult
    this.projects.forEach ((p) => {
      if (p.parentElement.style.display == 'block') {
        this.noresultsTarget.style.display = 'none';
      }
    });
  };
}
