{ Meteor } = require 'meteor/meteor'
{ _ } = require 'meteor/underscore'
{ ValidatedMethod } = require 'meteor/mdg:validated-method'
{ SimpleSchema } = require 'meteor/aldeed:simple-schema'
{ DDPRateLimiter } = require 'meteor/ddp-rate-limiter'

getBadge = new ValidatedMethod
	name: 'getBadge',
	validate: new SimpleSchema(
		url: { type: String }
	).validator(),
	run: ->
		console.log "Methods has been ran"
