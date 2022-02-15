import EyeIcon      from '../../../assets/images/eye.svg'
import EyeIconSlash from '../../../assets/images/eye-slash.svg'

let Calendar = class {
  constructor(calendarDiv) {
    this.div     = calendarDiv;
    this.state   = calendarDiv.getAttribute('data-calendar-state');
    this.nameStr = calendarDiv.getAttribute('data-calendar-name');
    this.nameDiv = calendarDiv.querySelector('.calendar-name');
    this.eye     = calendarDiv.querySelector('.eye-icon');
  }

  get eventBadges() {
    return calendarEventBadgesArr.filter((eventBadge) => {
      return eventBadge.getAttribute('data-calendar-name') === this.nameStr
    });
  };

  toggle() {
    this.toggleEventBadges();
    this.toggleGreyNameOut();
    this.toggleEyeIcon();
    this.toggleState();
  };

  toggleEventBadges() {
    if (this.state === 'displayed') {
      this.eventBadges.map((eventBadge) => {
        eventBadge.style.display = 'none';
        eventBadge.classList.remove('d-grid');
      });
    } else if (this.state === 'hidden') {
      this.eventBadges.map((eventBadge) => {
        eventBadge.style.display = 'grid'
        eventBadge.classList.add('d-grid');
      });
    }
  };

  toggleGreyNameOut() {
    if (this.state === 'displayed') {
      this.nameDiv.classList.add('text-muted');
    } else if (this.state === 'hidden') {
      this.nameDiv.classList.remove('text-muted');
    };
  };

  toggleEyeIcon() {
    if (this.state === 'displayed') {
      this.eye.src = EyeIconSlash;
    } else if (this.state === 'hidden') {
      this.eye.src = EyeIcon;
    };
  };

  toggleState() {
    if (this.state === 'displayed') {
      this.div.setAttribute('data-calendar-state', 'hidden');
      this.state = 'hidden';
    } else if (this.state === 'hidden') {
      this.div.setAttribute('data-calendar-state', 'displayed');
      this.state = 'displayed';
    };
  };

  displayEvents() {
    this.eventBadges.map((eventBadge) => {
      eventBadge.style.display = 'grid'
      eventBadge.classList.add('d-grid');
    });
  }
};

var calendars;
var calendarDivsArr;
var calendarEventBadgesArr;

var init = function(payload) {
  _cacheDom();
  _displayEvents();
  _bindEvents();
};

var _cacheDom = function() {
  calendarDivsArr        = Array.from(document.getElementsByClassName('calendar-sidebar-item'));
  calendarEventBadgesArr = Array.from(document.querySelectorAll('table .calendar-event-link'));
  calendars = _createCalendars();
};

var _createCalendars = function() {
  return calendarDivsArr.map((calendarDiv) => {
    return new Calendar(calendarDiv);
  });
};

// Initial toggle to display every calendar's events
var _displayEvents = function() {
  for (let calendar of calendars) {
    if(calendar.state === 'hidden') calendar.toggle();
  };
};

var _bindEvents = function() {
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
  for (let calendar of calendars) {
    calendar.eye.addEventListener('click', (event) => {
      event.preventDefault();
      calendar.toggle();
    });
  };
};


// Loads on 'turbo:frame-render
// Iterate calendars and hide badges which belongs to a hidden calendar
var _initializeEvents = function() {
  var displayedCalendars = calendars.filter((calendar) => {
    return calendar.state === 'displayed'
  });

  displayedCalendars.map((calendar) => {
    calendar.displayEvents();
  });
};

export default { init: init }
