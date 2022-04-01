import { Controller } from "@hotwired/stimulus"

//
// ToggleController
//
// Show or hide <div> within a <form> and respectively add or remove
// its `name` attribute.
// This way, if a section is hidden, the <input> it contains are not submitted.
//
// Expect a swtichTarget, typically a clickable radio button, to trigger
// the toggling.
//
// Relies on `data-attributes` to fetch related elements:
//   -> on the container:
//     - data-controller="forms--toggle"
//         Binds the controller to interact with the embedded elements
//
//   -> on the switch (anything that can be "checked")
//     - data-action="click->forms--toggle#toggle"
//         Bind click events to the function `toggle`
//     - data-forms--toggle-div-id="some_id"
//         Use to identify the <div>s to hide or show
//     - data-forms--toggle-field-name="model[attribute]"
//         Use to identify the <input>s to enable or disable
//
//   -> on the <div> to hide or show
//     - data-forms--toggle-target="div"
//         Allow the <div> to be a candidate for hide / show
//     - data-forms--toggle-id="some_id"
//         Allow the <div> to be identified as the valid candidate.
//
//   -> on the <input> to enable or disable
//     - data-forms--toggle-target="field"
//         Allow the <input> to be a candidate for being enabled or disabled
//     - data-forms--toggle-field-name="model[attribute]"
//         Allow the <input> to be identified as the valid candidate
//
//
// Example:
//   <!-- I. Bind the Stimulus controller -->
//   <div data-controller="forms--toggle" data-forms--toggle-target="div">
//
//     <!-- II. Add a switch button -->
//     <input
//       type="checkbox"
//       data-action="click->forms--toggle#toggle">
//
//     <!-- III. Add d <div> to hide or show -->
//     <div
//       data-forms--toggle-target="div"
//       data-forms--toggle-id="some_id">
//
//        <!-- IV. Have input to disable or enable -->
//        <input
//          data-forms--toggle-target="field"
//          data-forms--toggle-field-name="model[attribute]">
//     </div>
//   </div>
//
export default class extends Controller {
  static targets = ["div", "field"]

  toggleDiv(event) {
    var divId     = this.getDivId(event);
    var fieldName = this.getFieldName(event);

    event.target.checked ?
      this.show(divId, fieldName) :
      this.hide(divId, fieldName);
  }

  show(divId, fieldName) {
    this.showDiv(divId);
    this.enableFields(fieldName);
  }

  hide(divId, fieldName) {
    this.hideDiv(divId);
    this.disableFields(fieldName);
  }

  showDiv(divId) {
    this.getDivs(divId).forEach((div) => {
      div.style.display = 'flex';
    })
  }

  hideDiv(divId) {
    this.getDivs(divId).forEach((div) => {
      div.style.display = 'none';
    })
  }

  enableFields(fieldName) {
    this.getFields(fieldName).forEach((field) => {
      field.setAttribute('name', fieldName);
    })
  }

  disableFields(fieldName) {
    this.getFields(fieldName).forEach((field) => {
      field.removeAttribute('name', fieldName);
    })
  }

  getDivs(divId) {
    return this.divTargets.filter((divTarget) => {
      return divTarget.getAttribute('data-forms--toggle-id') == divId
    })
  }

  getFields(fieldName) {
    return this.fieldTargets.filter((fieldTarget) => {
      return fieldTarget.getAttribute('data-forms--toggle-field-name') == fieldName
    })
  }

  getDivId(e) {
    return e.target.getAttribute('data-forms--toggle-div-id');
  }

  getFieldName(e) {
    return e.target.getAttribute('data-forms--toggle-field-name');
  }
}
