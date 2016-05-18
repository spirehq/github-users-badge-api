{ Meteor } = require 'meteor/meteor'
{ Repositories } = require '../imports/api/repositories/collection.coffee'
{ Packages } = require '../imports/api/packages/collection.coffee'
{ Files } = require '../imports/api/files/collection.coffee'

Meteor.publish 'repository', (url) ->
	Repositories.find {url}

# TODO Problem: unable to limit number of returned items because of multiple cursors
#Meteor.publishComposite 'files', (url) ->
#	find: -> Packages.find {url}
#	children: [
#		{
#			find: (pack) -> Files.find {packages: pack.name}
#		}
#	]

Meteor.publish 'files', (url, limit) ->
	pack = Packages.findOne {url}
	return @ready() if not pack
	[Packages.find({url}), Files.find({packages: pack.name}, {limit})]
