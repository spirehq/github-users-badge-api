{ Mongo } = require 'meteor/mongo';

class FilesCollection extends Mongo.Collection

Files = new FilesCollection("Files")

Files.allow
  insert: ->
    false
  update: ->
    false
  remove: ->
    false

FilePreSave = (userId, changes) ->
  now = new Date()
  changes.updatedAt = changes.updatedAt or now

Files.before.insert (userId, File) ->
  File._id ?= Random.id()
  now = new Date()
  _.defaults File,
    updatedAt: now
    createdAt: now
  FilePreSave.call this, userId, File
  true

Files.before.update (userId, File, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set or {}
  FilePreSave.call this, userId, modifier.$set
  true

exports.Files = Files
