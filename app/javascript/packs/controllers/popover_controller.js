import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "popover", "htmlPopover" ]

  connect() {
    this.popoverTargets.map((popover) => {
      new bootstrap.Popover(popover)
    })

    this.htmlPopoverTargets.map((popover) => {
      new bootstrap.Popover(
        popover,
        {
          html: true,
          sanitize: false
        }
      )
    });
  }
}
