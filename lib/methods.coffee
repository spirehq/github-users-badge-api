{ Meteor } = require 'meteor/meteor'
{ _ } = require 'meteor/underscore'
{ ValidatedMethod } = require 'meteor/mdg:validated-method'
{ SimpleSchema } = require 'meteor/aldeed:simple-schema'
{ DDPRateLimiter } = require 'meteor/ddp-rate-limiter'
{ Repositories } = require '../imports/api/repositories/collection.coffee'

getBadge = new ValidatedMethod
	name: 'getBadge',
	validate: new SimpleSchema(
		url: { type: String }
	).validator(),
	run: ({url}) ->
		repository = Repositories.findOne {url}
		return false if not repository
		repository.users
