import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "modal"
  ]

  displayModal(event) {
    var eventUrl = this.getEventUrl(event);

    fetch(eventUrl, {
      headers: {
        'Accept': 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml'
      }
    }).then(this.modal.show());
  }

  getEventUrl(data) {
    var eventId    = data.target.closest('a').dataset['eventId'];

    return [window.location.origin, 'events', eventId].join('/')
  }

  get modal() {
    return new bootstrap.Modal(this.modalTarget);
  }
}
