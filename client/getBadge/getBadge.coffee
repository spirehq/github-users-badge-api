{ Template } = require 'meteor/templating'

Template.getBadge.helpers
	test: ->
		true

Template.getBadge.events
	"submit .repository-form": (event, template) ->
		event.preventDefault()
		
		Meteor.call 'getBadge', {url: "asd"}, ->
			console.log "Response received"
