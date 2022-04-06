import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateField", "modal"]

  connect() {
    this.element.addEventListener('turbo:submit-end', (event) => {
      if (event.detail.fetchResponse.response.status === 303 ) {
        this.hideModal();
      }
    });

    this.element.addEventListener('turbo:before-render', (event) => {
      this.configureFlatpickr(this.getStartDateFromEvent(event));
    });
  }

  dateFieldTargetConnected(element) {
    this.configureFlatpickr(element.value)
  }

  configureAndShowModal(event) {
    this.configureFlatpickr(this.getStartDateFromEvent(event));
    this.showModal();
  }

  configureFlatpickr(date) {
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

  showModal() {
    this.modal.show();
  }

  hideModal() {
    this.modal.hide();
  }

  get modal() {
    if (this._modal == undefined) {
      this._modal = new bootstrap.Modal(this.modalTarget);
    }
    return this._modal;
  }
}
