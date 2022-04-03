import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    this.element.addEventListener('turbo:submit-end', (event) => {
      if (event.detail.fetchResponse.response.status === 303 ) {
        this.hide_modal();
      }
    });

    this.element.addEventListener('turbo:before-render', (event) => {
      this.reconfigure_flatpickr();
    });
  }

  configure_and_show_modal(event) {
    const date = event.target.dataset.date;

    this.configure_flatpickr(date);
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
