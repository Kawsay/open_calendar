import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateField", "modal"]

  connect() {
    this.element.addEventListener('turbo:submit-end', (event) => {
      if (event.detail.fetchResponse.response.status === 303 ) {
        this.hide_modal();
      }
    });

    this.element.addEventListener('turbo:before-render', (event) => {
      this.configure_flatpickr(this.getStartDateFromEvent(event));
    });
  }

  dateFieldTargetConnected(element) {
    this.configure_flatpickr(element.value)
  }

  configure_and_show_modal(event) {
    this.configure_flatpickr(this.getStartDateFromEvent(event));
    this.show_modal();
  }

  configure_flatpickr(date) {
    flatpickr("[data-behavior='flatpickr']", {
      altInput:      true,
      altFormat:     'd F Y',
      altInputClass: 'form-control input text-dark',
      dateFormat:    'd/m/Y H:i',
      defaultDate:   date,
      mode:          'range',
    });
  }

  getStartDateFromEvent(event) {
    return event.target.dataset.date
  }

  show_modal() {
    this.modal.show();
  }

  hide_modal() {
    this.modal.hide();
  }

  get modal() {
    if (this._modal == undefined) {
      this._modal = new bootstrap.Modal(this.modalTarget);
    }
    return this._modal;
  }
}
