// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import TurboModalController from "./turbo_modal_controller"
application.register("turbo-modal", TurboModalController)

import MenuController from "./menu_controller"
application.register("menu", MenuController)

import HideShowController from "./hideshow"
application.register("hideshow", HideShowController)

import FilterController from "./filter_controller"
application.register("filter", FilterController)

import BookingController from "./booking_controller"
application.register("booking", BookingController)

import ClusterController from "./cluster_controller"
application.register("cluster", ClusterController)

import ResourceController from "./resource_controller"
application.register("resource", ResourceController)
