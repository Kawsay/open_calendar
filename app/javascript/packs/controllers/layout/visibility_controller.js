import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hideable"]

  hideIfOutsideClick(event) {
    // Early return if clicked within element
    if(this.element === event.target || this.element.contains(event.target)) return

    this.hideTargets()
  }

  hideTargets() {
    this.hideableTargets.forEach((hideableTarget) => {
      hideableTarget.style.display = 'none';
    });
  }
}
