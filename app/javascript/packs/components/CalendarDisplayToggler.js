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

      console.log(calendarState)
      console.log(calendarName)

      _toggleEventBadges(calendarState, calendarName);
    });
  };
};

var _toggleEventBadges = function(calendarState, calendarName) {
  var filteredEventBadges = calendarEventBadgesArr.filter((eventBadge) => {
    _belongsToThisCalendar(eventBadge);
  });

  filteredEventBadges.map((eventBadge) => {
    _toggleEventBadge(eventBadge, calendarState);
  });
};

var _belongsToThisCalendar = function(eventBadge, calendarName) {
  return eventBadge.getAttribute('data-calendar-name') === calendarName;
};

var _toggleEventBadge = function(eventBadge, calendarState) {
  if (calendarState === 'displayed') {
    eventBadge.style.display = 'none';
  } else if (calendarState === 'hidden') {
    eventBadge.style.display = 'inline-block !important'
  };
};

export default { init: init }
