{ Mongo } = require 'meteor/mongo';

class RepositoriesCollection extends Mongo.Collection

Repositories = new RepositoriesCollection("Repositories")

Repositories.allow
  insert: ->
    false
  update: ->
    false
  remove: ->
    false

RepositoryPreSave = (userId, changes) ->
  now = new Date()
  changes.updatedAt = changes.updatedAt or now

Repositories.before.insert (userId, Repository) ->
  Repository._id ?= Random.id()
  now = new Date()
  _.defaults Repository,
    updatedAt: now
    createdAt: now
  RepositoryPreSave.call this, userId, Repository
  true

Repositories.before.update (userId, Repository, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set or {}
  RepositoryPreSave.call this, userId, modifier.$set
  true

exports.Repositories = Repositories
