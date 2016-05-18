{ Meteor } = require 'meteor/meteor'
{ Repositories } = require '../imports/api/repositories/collection.coffee'
{ Packages } = require '../imports/api/packages/collection.coffee'
{ Files } = require '../imports/api/files/collection.coffee'

Meteor.publish 'repository', (url) ->
	Repositories.find {url}

Meteor.publishComposite 'files', (url) ->
	find: -> Packages.find {url}
	children: [
		{
			find: (pack) -> Files.find {packages: pack.name}
		}
	]
