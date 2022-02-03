var addEventModalDiv;
var addEventButtons;
var userField;
var userFieldDiv;
var isRelatedToAUserButton;
var titleField;
var typeField;
var locationField;
var descriptionField;

var init = function(payload) {
  _cacheDom();
  _bindEvents();
};

var _cacheDom = function() {
  addEventButtons        = document.getElementsByClassName('add-event-btn');
  addEventModalDiv       = document.getElementById('add-event-modal');
  userField              = addEventModalDiv.querySelector('#event_user_id');
  userFieldDiv           = userField.parentNode.parentNode;
  isRelatedToAUserButton = addEventModalDiv.querySelector('#event_is_related_to_a_user');
  titleField             = addEventModalDiv.querySelector('#event_title');
  typeField              = addEventModalDiv.querySelector('#event_event_type_id');
  locationField          = addEventModalDiv.querySelector('#event_location');
  descriptionField       = addEventModalDiv.querySelector('#event_description');
};

var _bindEvents = function () {
  // Display a form inside a modal to create new Event binded to the selected date
  for (let addEventButton of addEventButtons) {
    addEventButton.addEventListener('click', (event) => {
      event.preventDefault();

      var startDate = addEventButton.getAttribute('data-start-date');
      var addEventModalObj = new bootstrap.Modal(addEventModalDiv);

      _resetForm();
      _configureFlatpickr(startDate);
      addEventModalObj.show();
    });
  };

  // Display / hide User field on switch click
  isRelatedToAUserButton.addEventListener('click', () => {
    _toggleUserField();
  })
};

// Clear out potential previous form inputs
var _resetForm = function() {
  [titleField, typeField, locationField, descriptionField].forEach((field) => {
    field.value = '';
  });

  isRelatedToAUserButton.checked = false;
  _toggleUserField();
};

// Set up Flatpickr date-picker with defaultDate selected by the user
var _configureFlatpickr = function (startDate) {
  flatpickr("[data-behavior='flatpickr']", {
    altInput:      true,
    altFormat:     'd F Y',
    altInputClass: 'form-control input text-dark',
    dateFormat:    'd/m/Y H:i',
    defaultDate:   startDate,
    mode:          'range',
  })
};

// Display / hide User field
var _toggleUserField = function () {
  if (isRelatedToAUserButton.checked) {
    userField.setAttribute('name', 'event[user_id]');
    userFieldDiv.style.display = 'flex';
  } else {
    userField.removeAttribute('name');
    userFieldDiv.style.display = 'none';
  }
};

export default { init: init }
