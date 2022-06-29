import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["limited_activities_checkbox", "limited_activities"]

  connect() {
    console.log("cluster controller");
    display_if_checked(this.limited_activitiesTarget, this.limited_activities_checkboxTarget);
  }
}
