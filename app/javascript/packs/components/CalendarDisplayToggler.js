import EyeIcon      from '../../../assets/images/eye.svg'
import EyeIconSlash from '../../../assets/images/eye-slash.svg'

var calendarNameDiv;
var calendarNameDivArr;
var calendarEyeIcons;
var calendarEyeIconsArr;
var calendarEventBadges;
var calendarEventBadgesArr;
var eyeIcon;
var eyeSlashIcon;

var init = function(payload) {
  _cacheDom();
  _initializeEvents();
  _bindEvents();
};

var _cacheDom = function() {
  calendarNameDiv        = document.getElementsByClassName('calendar-name');
  calendarNameDivArr     = Array.from(calendarNameDiv);
  calendarEyeIcons       = document.getElementsByClassName('eye-icon');
  calendarEyeIconsArr    = Array.from(calendarEyeIcons);
  calendarEventBadges    = document.querySelectorAll('table .calendar-event-link');
  calendarEventBadgesArr = Array.from(calendarEventBadges);
};

var _bindEvents = function() {
  // Adds an event on each eye icon to hide / display related calendar's events
  _bindToggleEvent();

  // Bind events after a turbo-frame is rendered
  document.addEventListener('turbo:frame-render', (event) => {
    _cacheDom();
    _initializeEvents();
  });
};

// Adds an event on each calendar eye icon, which, when clicked, hide
// or show the related event badges
var _bindToggleEvent = function() {
  for (let calendarEyeIcon of calendarEyeIcons) {
    calendarEyeIcon.addEventListener('click', (event) => {
      event.preventDefault();

      var calendarState   = calendarEyeIcon.getAttribute('data-calendar-state');
      var calendarNameStr = calendarEyeIcon.getAttribute('data-calendar-name');
      var calendarNameDiv = _getCalendarNameDiv(calendarNameStr);

      _toggleEventBadges(calendarState, calendarNameStr, calendarEyeIcon);
      _toggleGreyCalendarNameOut(calendarNameDiv, calendarState);
      _toggleEyeIcon(calendarEyeIcon, calendarState);
    });
  };
};

// Hide or show event badges related to a calendar
// Update their 'calendar-state' data-attribute
var _toggleEventBadges = function(calendarState, calendarNameStr, calendarEyeIcon) {
  var relatedEventBadges = _getEventBadgesRelatedToThisCalendar(calendarNameStr);

  relatedEventBadges.map((eventBadge) => {
    if (calendarState === 'displayed') {
      _hideEvent(eventBadge);
      calendarEyeIcon.setAttribute('data-calendar-state', 'hidden');
    } else if (calendarState === 'hidden') {
      _showEvent(eventBadge);
      calendarEyeIcon.setAttribute('data-calendar-state', 'displayed');
    };
    // _toggleEventBadge(eventBadge, calendarState, calendarEyeIcon);
  });
};

//  Grey a calendar name out or reset its style
var _toggleGreyCalendarNameOut = function(calendarNameDiv, calendarState) {
  calendarState === 'displayed' ? _muteCalendarName(calendarNameDiv) :  _unmuteCalendarName(calendarNameDiv)
};

// Replace eye icon by slash-eye icon, and the other way around
var _toggleEyeIcon = function(calendarEyeIcon, calendarState) {
  calendarState === 'displayed' ? calendarEyeIcon.src = EyeIconSlash : calendarEyeIcon.src = EyeIcon
};

// Loads on 'turbo:frame-render
// Iterate calendars and hide badges which belongs to a hidden calendar
var _initializeEvents = function() {
  // Select calendars with data-calendar-state set to 'hidden'
  var displayedCalendars = calendarEyeIconsArr.filter((calendarEyeIcon) => {
    return calendarEyeIcon.getAttribute('data-calendar-state') === 'displayed'
  });

  displayedCalendars.map((displayedCalendar) => {
    var calendarName = displayedCalendar.getAttribute('data-calendar-name');
    var eventBadges  = _getEventBadgesRelatedToThisCalendar(calendarName)
    
    eventBadges.map((eventBadge) => {
      _showEvent(eventBadge);
    });
  });
};

// Select the event badges related to a calendar
var _getEventBadgesRelatedToThisCalendar = function(calendarNameStr) {
  return calendarEventBadgesArr.filter((eventBadge) => {
    return eventBadge.getAttribute('data-calendar-name') === calendarNameStr
  });
};

// Find a calendar <div> by name
var _getCalendarNameDiv = function(calendarNameStr) {
  return calendarNameDivArr.find((calendarNameDiv) => {
    return calendarNameDiv.getAttribute('data-calendar-name') === calendarNameStr
  });
};


// Takes an eventBadge as input, set its display to 'none' and removes
// its 'd-grid' class
var _hideEvent = function(eventBadge) {
  eventBadge.style.display = 'none';
  eventBadge.classList.remove('d-grid');
};

// Takes an eventBadge as input, set its display to 'grid' and adds
// a 'd-grid' class
var _showEvent = function(eventBadge) {
  eventBadge.style.display = 'grid'
  eventBadge.classList.add('d-grid');
};

//  Greyed out a calendar name by adding a "text-muted" CSS class
var _muteCalendarName = function(calendarNameDiv) {
  calendarNameDiv.classList.add('text-muted');
}

//  Reset a calendar name color by removing its "text-muted" CSS class
var _unmuteCalendarName = function(calendarNameDiv) {
  calendarNameDiv.classList.remove('text-muted');
}

export default { init: init }
