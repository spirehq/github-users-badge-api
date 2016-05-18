{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'

Template.layout.helpers
	index: ->
		Meteor.absoluteUrl()
