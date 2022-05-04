import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "popover", "htmlPopover" ]

  connect() {
    this.instanciatePopovers()
    this.instanciateHtmlPopovers()
  }

  instanciatePopovers() {
    this.popoverTargets.map((popover) => {
      new bootstrap.Popover(popover)
    })
  }

  instanciateHtmlPopovers() {
    this.htmlPopoverTargets.map((popover) => {
      new bootstrap.Popover(
        popover,
        {
          html: true,
          sanitize: false,
        }
      )
    });
  }
}
