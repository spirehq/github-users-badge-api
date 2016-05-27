{ Mongo } = require 'meteor/mongo';

class EventsCollection extends Mongo.Collection

Events = new EventsCollection("Events")

Events.allow
  insert: ->
    false
  update: ->
    false
  remove: ->
    false

EventPreSave = (userId, changes) ->
  now = new Date()
  changes.updatedAt = changes.updatedAt or now

Events.before.insert (userId, Event) ->
  Event._id ?= Random.id()
  now = new Date()
  _.defaults Event,
    updatedAt: now
    createdAt: now
  EventPreSave.call this, userId, Event
  true

Events.before.update (userId, Event, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set or {}
  EventPreSave.call this, userId, modifier.$set
  true

exports.Events = Events
