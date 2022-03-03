import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "popover" ]

  popoverTargetConnected() {
    var popovers = this.popoverTargets;
    popovers.map((popover) => { new bootstrap.Popover(popover) })
  }
}
