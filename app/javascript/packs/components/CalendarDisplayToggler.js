var calendarEyeIcons;
var calendarEventBadges;
var calendarEventBadgesArr;
var eyeIcon;
var eyeSlashIcon;

var init = function(payload) {
  _cacheDom();
  _bindEvents();
};

var _cacheDom = function() {
  calendarEyeIcons       = document.getElementsByClassName('eye-icon');
  calendarEventBadges    = document.querySelectorAll('table .calendar-event-link');
  calendarEventBadgesArr = Array.from(calendarEventBadges);
};

var _bindEvents = function() {
  for (let calendarEyeIcon of calendarEyeIcons) {
    calendarEyeIcon.addEventListener('click', (event) => {
      event.preventDefault();

      var calendarState = calendarEyeIcon.getAttribute('data-calendar-state');
      var calendarName  = calendarEyeIcon.getAttribute('data-calendar-name');

      _toggleEventBadges(calendarState, calendarName, calendarEyeIcon);
    });
  };
};

var _toggleEventBadges = function(calendarState, calendarName, calendarEyeIcon) {
  var filteredEventBadges = calendarEventBadgesArr.filter((eventBadge) => {
    return eventBadge.getAttribute('data-calendar-name') === calendarName
  });

  filteredEventBadges.map((eventBadge) => {
    _toggleEventBadge(eventBadge, calendarState, calendarEyeIcon);
  });
};

var _toggleEventBadge = function(eventBadge, calendarState, calendarEyeIcon) {
  if (calendarState === 'displayed') {
    eventBadge.style.display = 'none';
    eventBadge.classList.remove('d-grid');
    calendarEyeIcon.setAttribute('data-calendar-state', 'hidden');
  } else if (calendarState === 'hidden') {
    eventBadge.style.display = 'inline-block !important'
    eventBadge.classList.add('d-grid');
    calendarEyeIcon.setAttribute('data-calendar-state', 'displayed');
  };
};

export default { init: init }
