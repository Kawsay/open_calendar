// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbo from "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../stylesheets/application";

Rails.start()
ActiveStorage.start()

window.Stimulus = Application.start()
const context = require.context("./controllers", true, /\.js$/)
Stimulus.load(definitionsFromContext(context))

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
