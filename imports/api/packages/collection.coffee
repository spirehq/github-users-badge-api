{ Mongo } = require 'meteor/mongo';

class PackagesCollection extends Mongo.Collection

Packages = new PackagesCollection("Packages")

Packages.allow
  insert: ->
    false
  update: ->
    false
  remove: ->
    false

PackagePreSave = (userId, changes) ->
  now = new Date()
  changes.updatedAt = changes.updatedAt or now

Packages.before.insert (userId, Package) ->
  Package._id ?= Random.id()
  now = new Date()
  _.defaults Package,
    updatedAt: now
    createdAt: now
  PackagePreSave.call this, userId, Package
  true

Packages.before.update (userId, Package, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set or {}
  PackagePreSave.call this, userId, modifier.$set
  true

exports.Packages = Packages
