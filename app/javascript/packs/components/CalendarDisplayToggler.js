// WIP
// Still pretty buggy & non optimal. Don't even know if the approch correct.
//
// Idea is: badges (= event representation) HTML templates includes CSS to hide them
// at 1st load. If they've the data-attribute "calendar-state" set to "displayed", 
// they're displayed via JS.
// 
// This prevents badges to initialy appear and quickly disapear.
// It also allow all events to be loaded, which is to me a tradeoff between usability
// and complexity (would be lot more complexe to request only displayed calendars'
// events and request additionnal ones when eyes icons are clicked.)
//
// IDEA: Could a calendar frame be a TurboFrame with an id related to the position of
// the day in the month, and have Turbo replacing frames when needed ?? 

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
  calendarEyeIcons       = document.getElementsByClassName('eye-icon');
  calendarEyeIconsArr    = Array.from(calendarEyeIcons);
  calendarEventBadges    = document.querySelectorAll('table .calendar-event-link');
  calendarEventBadgesArr = Array.from(calendarEventBadges);
};

var _bindEvents = function() {
  _bindToggleEvent();

  document.addEventListener('turbo:frame-render', (event) => {
    _cacheDom();
    _initializeEvents();
    _bindToggleEvent();
  });
};

// Adds an event on each calendar eye icon, which, when clicked, hide
// or show the related event badges
var _bindToggleEvent = function() {
  for (let calendarEyeIcon of calendarEyeIcons) {
    calendarEyeIcon.addEventListener('click', (event) => {
      event.preventDefault();

      var calendarState = calendarEyeIcon.getAttribute('data-calendar-state');
      var calendarName  = calendarEyeIcon.getAttribute('data-calendar-name');

      _toggleEventBadges(calendarState, calendarName, calendarEyeIcon);
    });
  };
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

// Parameters:
//  - calendarName     <String>           = set by users (/[a-zA-Z0-9/)
//
// Select the event badges related to a calendar
var _getEventBadgesRelatedToThisCalendar = function(calendarName) {
  return calendarEventBadgesArr.filter((eventBadge) => {
    return eventBadge.getAttribute('data-calendar-name') === calendarName
  });
};

// Parameters:
//  - calendarState    <String>           = 'hidden' or 'displayed'
//  - calendarName     <String>           = set by users (/[a-zA-Z0-9/)
//  - calendarEyeIcon  <HTMLImageElement> = an <img> tag to illustrate the calendar state
//
// Hide or show event badges related to a calendar
// Update their 'calendar-state' data-attribute
var _toggleEventBadges = function(calendarState, calendarName, calendarEyeIcon) {
  var relatedEventBadges = _getEventBadgesRelatedToThisCalendar(calendarName);

  relatedEventBadges.map((eventBadge) => {
    _toggleEventBadge(eventBadge, calendarState, calendarEyeIcon);
  });
};

// Parameters:
//  - calendarState    <String>           = 'hidden' or 'displayed'
//  - calendarName     <String>           = set by User (/[a-zA-Z0-9/)
//  - calendarEyeIcon  <HTMLImageElement> = an <img> tag to illustrate the calendar state
//
// Hide or show an event badge
// Update its 'calendar-state' data-attribute
var _toggleEventBadge = function(eventBadge, calendarState, calendarEyeIcon) {
  if (calendarState === 'displayed') {
    _hideEvent(eventBadge);
    calendarEyeIcon.setAttribute('data-calendar-state', 'hidden');
  } else if (calendarState === 'hidden') {
    _showEvent(eventBadge);
    calendarEyeIcon.setAttribute('data-calendar-state', 'displayed');
  };
};

// Parameters:
//  - eventBadge      <HTMLElement>       = a <a> tag containing a <span> representing an event
//
// Takes an eventBadge as input, set its display to 'none' and removes
// its 'd-grid' class
var _hideEvent = function(eventBadge) {
  eventBadge.style.display = 'none';
  eventBadge.classList.remove('d-grid');
};

// Parameters:
//  - eventBadge      <HTMLElement>       = a <a> tag containing a <span> representing an event
//
// Takes an eventBadge as input, set its display to 'grid' and adds
// a 'd-grid' class
var _showEvent = function(eventBadge) {
  eventBadge.style.display = 'grid'
  eventBadge.classList.add('d-grid');
};

export default { init: init }
