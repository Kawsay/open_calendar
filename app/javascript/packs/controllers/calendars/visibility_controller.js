import { Controller } from "@hotwired/stimulus"
import EyeIcon      from '../../../../assets/images/eye.svg'
import EyeIconSlash from '../../../../assets/images/eye-slash.svg'

export default class extends Controller {
  static targets = [ "calendar", "event" ]

  eventTargetConnected() {
    var calendars = this.calendarTargets;

    calendars.map((calendar) => {
      var calendarEvents = this.calendar_events(calendar.dataset.calendarName);

      if (calendar.dataset.calendarVisible === 'true') {
        this.show_events(calendarEvents);
      }
    })
  }

  toggle(event) {
    event.preventDefault();

    var calendarName    = event.target.dataset.calendarName;
    var calendar        = this.calendar(calendarName)
    var calendarVisible = calendar.dataset.calendarVisible;
    var calendarEvents  = this.calendar_events(calendarName);
    var calendarEyeIcon = event.target;

    if (calendarVisible === 'false') {
     this.show_events(calendarEvents);
     this.unmute_name(calendar);
     this.set_visible_eye_icon(calendarEyeIcon);
     this.set_visible_state(calendar);
    } else if (calendarVisible === 'true') {
     this.hide_events(calendarEvents);
     this.mute_name(calendar);
     this.set_hidden_eye_icon(calendarEyeIcon);
     this.set_hidden_state(calendar);
    }
  }

  show_events(calendarEvents) {
    calendarEvents.map((calendarEvent) => {
      calendarEvent.style.display = 'grid'
      calendarEvent.classList.add('d-grid');
    });
  }

  hide_events(calendarEvents) {
    calendarEvents.map((calendarEvent) => {
      calendarEvent.style.display = 'none'
      calendarEvent.classList.remove('d-grid');
    });
  }

  unmute_name(calendarNameDiv) {
    calendarNameDiv.classList.remove('text-muted');
  }

  mute_name(calendarNameDiv) {
    calendarNameDiv.classList.add('text-muted');
  }

  set_visible_eye_icon(calendarEyeIcon) {
    calendarEyeIcon.src = EyeIcon;
  }

  set_hidden_eye_icon(calendarEyeIcon) {
    calendarEyeIcon.src = EyeIconSlash;
  }

  set_visible_state(calendar) {
    calendar.setAttribute('data-calendar-visible', 'true');
  }

  set_hidden_state(calendar) {
    calendar.setAttribute('data-calendar-visible', 'false');
  }

  calendar_events(calendarName) {
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
