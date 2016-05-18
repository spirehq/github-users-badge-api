fs = require "fs"
{ Meteor } = require "meteor/meteor"
{ Migrations } = require 'meteor/percolate:migrations'
{ Fixtures } = require "/imports/server/fixtures"
{ migrate } = require "/imports/server/migrate"
{ Repositories } = require "/imports/api/repositories/collection"
{ Packages } = require "/imports/api/packages/collection"
{ Files } = require "/imports/api/files/collection"
{ RepositoriesFixtures } = require "/imports/server/repositories/fixtures"
{ PackagesFixtures } = require "/imports/server/packages/fixtures"
{ FilesFixtures } = require "/imports/server/files/fixtures"

Fixtures.push Repositories, RepositoriesFixtures
Fixtures.push Packages, PackagesFixtures
Fixtures.push Files, FilesFixtures

Meteor.startup ->
  if not Migrations._collection.findOne("control")
    Fixtures.insertAll([])
  else
    Fixtures.ensureAll([])
  migrate()

process.on "SIGUSR2", Meteor.bindEnvironment ->
  filename = "/tmp/meteorReloadedCollectionNames"
  try
    fs.statSync(filename)
  catch err
    return if err.code is "ENOENT"
  reloadedCollectionNames = _.compact(fs.readFileSync(filename).toString().split("\n"))
  console.info("Reloading fixtures for " + if reloadedCollectionNames.length then reloadedCollectionNames.join(", ") else "all collections")
  Fixtures.insertAll(reloadedCollectionNames)
  migrate()
