import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "modal", "titleField", "calendarIdField", "locationField",
    "usersSwitch", "usersDiv", "userIdField", "descriptionField"
  ]

  toggle_users_field(event) {
    this.usersSwitchTarget.checked ?
      this.show_users_field() :
      this.hide_users_field();
  } 

  configure_and_show_modal(event) {
    const date = event.target.dataset.date;

    this.reset_form();
    this.configure_flatpickr(date);
    this.show_modal();
  }

  reset_form() {
    const fields = [
      this.titleFieldTarget,
      this.calendarIdFieldTarget,
      this.locationFieldTarget,
      this.userIdFieldTarget,
      this.descriptionFieldTarget
    ];

    fields.forEach( (field) => { field.value = '' } );

    this.usersSwitchTarget.checked = false;

    this.hide_users_field();
  }

  show_users_field() {
    this.usersDivTarget.setAttribute('name', 'event[user_id]');
    this.usersDivTarget.style.display = 'flex';
  }

  hide_users_field() {
    this.usersDivTarget.removeAttribute('name', 'event[user_id]');
    this.usersDivTarget.style.display = 'none';
  }

  configure_flatpickr(date) {
    flatpickr("[data-behavior='flatpickr']", {
      altInput:      true,
      altFormat:     'd F Y',
      altInputClass: 'form-control input text-dark',
      dateFormat:    'd/m/Y H:i',
      defaultDate:   date,
      mode:          'range',
    })
  }

  show_modal() {
    this.modal.show();
  }

  get modal() {
    return new bootstrap.Modal(this.modalTarget);
  }
}
