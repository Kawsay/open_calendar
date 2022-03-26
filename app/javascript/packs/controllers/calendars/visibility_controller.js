import { Controller } from "@hotwired/stimulus"
import EyeIcon      from '../../../../assets/images/eye.svg'
import EyeIconSlash from '../../../../assets/images/eye-slash.svg'

//
// VisibilityController
//
// This controller is responsible of show and hidding events related to a
// calendar.
//
// It relies on 3 data-attributes:
//   - data-calendar-visible: <boolean>
//       Whether or not the calendar is shown.
//       Attached to each calendars within the #calendar-sidebar
//       default: true
//   - data-calendar-name: <string>
//       The name of a calendar
//       Attached to each calendars within the #calendar-sidebar
//   - data-calendar-name: <string>
//       The name of a calendar of whom a event belongs
//       Attached to each events <a> tag within the calendar grid
//
// At 1st load, events are hidden (see calendars--calendar-controller).
// Once event targets are connected, we iterate calendars and show them (as
// data-calendar-visible is set to "true", every events are shown at this point)
// This allow keeping events hidden if we consult other months.
//
// Hidding a calendar and its events is done is 4 steps:
//   - its events are hidden (remove d-grid class + display = none)
//   - its name is muted (add text-muted class)
//   - its eye icon is replaced with a slashed version
//   - its data-calendar-visible is set to false
// Showing events is the reciprocal process.

export default class extends Controller {
  static targets = ["calendar", "event"]

  eventTargetConnected() {
    var calendars = this.calendarTargets;

    calendars.map((calendar) => {
      var calendarEvents = this.calendarEvents(calendar.dataset.calendarName);

      if (calendar.dataset.calendarVisible === 'true') {
        this.showEvents(calendarEvents);
      }
    })
  }

  toggle(event) {
    event.preventDefault();

    var calendarName    = event.target.dataset.calendarName;
    var calendar        = this.calendar(calendarName)
    var calendarVisible = calendar.dataset.calendarVisible;
    var calendarEvents  = this.calendarEvents(calendarName);
    var calendarEyeIcon = event.target;

    calendarVisible === 'false'
      ? this.showCalendar(calendar, calendarEvents, calendarEyeIcon)
      : this.hideCalendar(calendar, calendarEvents, calendarEyeIcon)
  }

  showCalendar(calendar, calendarEvents, calendarEyeIcon) {
   this.showEvents(calendarEvents);
   this.unmuteName(calendar);
   this.setVisibleEyeIcon(calendarEyeIcon);
   this.setVisibleState(calendar);
  }

  hideCalendar(calendar, calendarEvents, calendarEyeIcon) {
   this.hideEvents(calendarEvents);
   this.muteName(calendar);
   this.setHiddenEyeIcon(calendarEyeIcon);
   this.setHiddenState(calendar);
  }

  showEvents(calendarEvents) {
    calendarEvents.map((calendarEvent) => {
      calendarEvent.style.display = 'grid'
      calendarEvent.classList.add('d-grid');
    });
  }

  hideEvents(calendarEvents) {
    calendarEvents.map((calendarEvent) => {
      calendarEvent.style.display = 'none'
      calendarEvent.classList.remove('d-grid');
    });
  }

  unmuteName(calendarNameDiv) {
    calendarNameDiv.classList.remove('text-muted');
  }

  muteName(calendarNameDiv) {
    calendarNameDiv.classList.add('text-muted');
  }

  setVisibleEyeIcon(calendarEyeIcon) {
    calendarEyeIcon.src = EyeIcon;
  }

  setHiddenEyeIcon(calendarEyeIcon) {
    calendarEyeIcon.src = EyeIconSlash;
  }

  setVisibleState(calendar) {
    calendar.setAttribute('data-calendar-visible', 'true');
  }

  setHiddenState(calendar) {
    calendar.setAttribute('data-calendar-visible', 'false');
  }

  calendarEvents(calendarName) {
    return this.events.filter((e) => {
      return e.getAttribute('data-calendar-name') === calendarName
    });
  }

  calendar(calendarName) {
    return this.calendarTargets.find((calendarTarget) => {
      return calendarTarget.getAttribute('data-calendar-name') === calendarName
    });
  }

  get events() {
    return this.eventTargets
  }
}
