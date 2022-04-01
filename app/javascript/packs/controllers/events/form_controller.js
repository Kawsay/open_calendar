import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "modal", "titleField", "dateField", "calendarIdField", "locationField",
    "usersSwitch", "usersDiv", "userIdField", "descriptionField",
    "invitationsSwitch", "invitationsDiv"
  ]

  connect() {
    this.element.addEventListener('turbo:submit-end', (event) => {
      if (event.detail.fetchResponse.response.status === 303 ) {
        this.hide_modal();
      }
    });

    this.element.addEventListener('hide.bs.modal', (event) => {
      this.reset_form_errors();
    });

    this.element.addEventListener('turbo:before-render', (event) => {
      this.reconfigure_flatpickr();
    });
  }

  toggle_users_field(event) {
    this.usersSwitchTarget.checked ?
      this.show_users_field() :
      this.hide_users_field();
  }

  toggle_invitations_field(event) {
    this.invitationsSwitchTarget.checked ?
      this.show_invitations_field() :
      this.hide_invitations_field();
  }

  configure_and_show_modal(event) {
    const date = event.target.dataset.date;

    this.reset_form_values();
    this.configure_flatpickr(date);
    this.show_modal();
  }

  reset_form_values() {
    this.fields.forEach((field) => { field.value = '' } );
    this.usersSwitchTarget.checked = false;
    this.invitationsSwitchTarget.checked = false;
    this.hide_users_field();
  }

  reset_form_errors() {
    let error_explanation = document.querySelector('#error_explanation');
    if (document.contains(error_explanation)) error_explanation.remove();

    this.fields.forEach((field) => { field.classList.remove('is-invalid') });
  }

  show_users_field() {
    this.usersDivTarget.setAttribute('name', 'event[user_id]');
    this.usersDivTarget.style.display = 'flex';
  }

  show_invitations_field() {
    this.invitationsDivTarget.setAttribute('name', 'event[attendees_id]');
    this.invitationsDivTarget.style.display = 'flex';
  }

  hide_users_field() {
    this.usersDivTarget.removeAttribute('name', 'event[user_id]');
    this.usersDivTarget.style.display = 'none';
  }

  hide_invitations_field() {
    this.invitationsDivTarget.removeAttribute('name', 'event[attendees_id]');
    this.invitationsDivTarget.style.display = 'none';
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

  reconfigure_flatpickr() {
    console.log('date')
    console.log(this.dateTarget)
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

  get fields() {
    const fields = [
      this.titleFieldTarget,
      this.calendarIdFieldTarget,
      this.locationFieldTarget,
      this.userIdFieldTarget,
      this.descriptionFieldTarget
    ];

    return fields;
  }
}
