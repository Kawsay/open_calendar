import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "resetable"]
  static values = { type: String }

  connect() {
    if (this.scope.element.getAttribute('data-form-type') === 'modal') {
      document.addEventListener('hide.bs.modal', (event) => {
        this.reset();
      });
    }
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
