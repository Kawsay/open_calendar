import { Controller } from "@hotwired/stimulus"
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import interactionPlugin from "@fullcalendar/interaction";
import bootstrap5Plugin from '@fullcalendar/bootstrap5';
import 'bootstrap-icons/font/bootstrap-icons.css';
import PlusIcon from '../../../../assets/images/plus.svg'


export default class extends Controller {
  connect() {
    let calendarEl = document.getElementById('calendar');

    let calendar = new Calendar(calendarEl, {
      // Initialization
      plugins: [
        dayGridPlugin, timeGridPlugin, listPlugin, interactionPlugin,
        bootstrap5Plugin
      ],

      // Style and display config
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,listWeek'
      },
      initialView: 'dayGridMonth',
      themeSystem: 'bootstrap5',
      height: '80vh',

      // Calendar
      fixedWeekCount: false,
      showNonCurrentDates: false,
      editable: true,

      // Events
      displayEventTime: false,
      // TODO: Find a way to limit the number of events. The options commented
      // bellow makes the whole calendar scrollable, instead of limiting the
      // number of events.
      //   dayMaxEvents:    true,
      //   dayMaxEventRows: 3,
      events: {
        eventLimitText: 'more',
        url:          '/api/v1/events',
        method:       'GET',
        lazyFecthing: true,
        startParam:   'event[start_date]',
        endParam:     'event[end_date]',
        extraParams: {
          'event[team_name]': this.getCurrentTeam()
        },
      },

      // Hooks
      eventDidMount:   (data) => { this.setEventLink(data) },
      dayCellDidMount: (data) => { this.addPlusIconToFutureDayCells(data) }
    });

    calendar.render();
  }

  getCurrentTeam() {
    return document.getElementById('navbarDropdown').innerHTML
  }

  setEventLink(data) {
    data.el.href = this.getEventLinkLocation(data.event._def.extendedProps.eventId)
  }

  getEventLinkLocation(eventId) {
    return `${window.location.origin}/events/${eventId}`
  }

  // Add a "+" button on today and future cells
  addPlusIconToFutureDayCells(data, createEl) {
    if(data.el.classList.contains("fc-day-future") || data.el.classList.contains("fc-day-today")) {
      var element = data.el.querySelectorAll(".fc-daygrid-day-frame > .fc-daygrid-day-bg")[0]
      var plusIconElement =
        `<div class='add-event'>
           <img src=${PlusIcon} width="20" height="20"
             data-action="click->events--form#configureAndShowModal"
             data-date="${this.formatDate(data)}"
           >
         </div>`

      element.innerHTML = element.innerHTML + plusIconElement
    }
  }

  //
  // Functions to show/hide a calendar and its related events
  //
  // Main function
  setVisibilityAttributes(data) {
    this.hideEvent(data)
    this.setDataCalendarName(data)
    this.setDataVisibilityTarget(data)
  }

  // Hide event at first load
  hideEvent(data) {
    data.el.style.display = 'none'
    data.el.classList.remove('d-grid')
  }

  // Add data-calendar-name to events
  setDataCalendarName(data) {
    data.el.setAttribute('data-calendar-name', data.event._def.extendedProps.calendarName)
  }

  // Add data-calendar--visibility-target attribute to events
  setDataVisibilityTarget(data) {
    data.el.setAttribute('data-calendars--visibility-target', 'event')
  }


  formatDate(data) {
    return data.date.toLocaleString('fr-FR', { dateStyle: 'short' })
  }
}
