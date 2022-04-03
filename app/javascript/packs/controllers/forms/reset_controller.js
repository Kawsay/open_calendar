import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["resetable"]

  connect() {
    document.addEventListener('hide.bs.modal', (event) => {
      this.reset();
    });
  }

  reset() {
    this.resetableTargets.forEach((field) => {
      this.resetField(field);
      this.resetCssClass(field);
    })

    this.removeErrorDiv();
  }

  resetField(field) {
    field.type === "checkbox" ?
      field.checked = false :
      field.value = '';
  }

  resetCssClass(field) {
    field.classList.remove('is-invalid');
  }

  removeErrorDiv() {
    var errorDiv = document.querySelector("#error_explanation")
    if (errorDiv) errorDiv.remove();
  }
}
