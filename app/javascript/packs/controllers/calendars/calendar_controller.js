import { Controller } from "@hotwired/stimulus"
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import listPlugin from "@fullcalendar/list";
import interactionPlugin from "@fullcalendar/interaction";
import bootstrap5Plugin from '@fullcalendar/bootstrap5';
import 'bootstrap-icons/font/bootstrap-icons.css';


export default class extends Controller {
  connect() {
    let calendarEl = document.getElementById('calendar');

    let calendar = new Calendar(calendarEl, {
      // Initialization
      plugins: [
        dayGridPlugin, timeGridPlugin, listPlugin, interactionPlugin, bootstrap5Plugin
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
      selectable: true,
      select: function(info) {
        console.log('TODO: ->configure_and_show_modal()\nselected: ' + info.startStr + ' to ' + info.endStr);
      },
      editable: true,

      // Events
      displayEventTime: false,
      dayMaxEvents: 3,
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
      eventDidMount: (data) => { this.addDataAttributes(data) },
    });

    calendar.render();
  }

  getCurrentTeam() {
    return document.getElementById('navbarDropdown').innerHTML
  }

  addDataAttributes(data) {
    this.addCalendarNameAttribute(data);
  }

  addCalendarNameAttribute(data) {
    data.el.setAttribute(
      'data-calendar-name', data.event._def.extendedProps.calendarName
    );
  }
}
