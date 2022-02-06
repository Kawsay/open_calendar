// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbo from "@hotwired/turbo"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../stylesheets/application";

Rails.start()
ActiveStorage.start()

import "bootstrap";
window.bootstrap = require('bootstrap/dist/js/bootstrap.bundle.js')

import flatpickr from "flatpickr";
import { French } from "flatpickr/dist/l10n/fr.js"
flatpickr.localize(French);
require("flatpickr/dist/flatpickr.css");

import "trix"
import "@rails/actiontext"

require("trix")
require("@rails/actiontext")

import './customs/enable_tooltips'

import EventModalFormModifier from './components/EventModalFormModifier'
import CalendarDisplayToggler from './components/CalendarDisplayToggler'

const components = {
  'calendars/index': [EventModalFormModifier, CalendarDisplayToggler]
};


document.addEventListener('turbo:load', () => {
  const { route, payload } = JSON.parse(document.querySelector('meta[name="parameters"]').content)
  const componentsObj = components[route]

  if (componentsObj) {
    componentsObj.forEach((component) => {
      component.init(payload);
    });
  };
});
