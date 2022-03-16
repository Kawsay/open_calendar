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
      eventDidMount:   (data) => { this.addDataAttributes(data) },
      dayCellDidMount: (data) => { this.addPlusIconToFutureDayCells(data) }
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

  addPlusIconToFutureDayCells(data, createEl) {
    if(data.el.classList.contains("fc-day-future") || data.el.classList.contains("dc-day-today")) {
      var element = data.el.querySelectorAll(".fc-daygrid-day-frame > .fc-daygrid-day-bg")[0]
      var plusIconElement = `<div class='add-event'><a href="#"><img src=${PlusIcon} width="20" height="20"></a></div>`
        element.innerHTML = element.innerHTML + plusIconElement
    }
  }
}
