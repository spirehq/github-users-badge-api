{ Template } = require 'meteor/templating'

Template.getBadge.helpers
	test: ->
		true

Template.getBadge.onCreated ->
	@clearState = ->
		form = @$(".js-repository-form")
		message = @$(".js-error-message")
		form.removeClass "has-error has-warning"
		message.html ""

	@warning = (text) ->
		form = @$(".js-repository-form")
		message = @$(".js-error-message")
		form.addClass "has-warning"
		message.html text

	@error = (text) ->
		form = @$(".js-repository-form")
		message = @$(".js-error-message")
		form.addClass "has-error"
		message.html text

Template.getBadge.events
	"submit .js-repository-form": (event, instance) ->
		event.preventDefault()
		instance.clearState()

		input = instance.$(".js-repository-url")
		raw = input.val()

		if raw and raw.length
			isValid = validateRepositoryUrl raw

			if isValid
				url = resolveRepositoryUrl raw
				console.log url

				Meteor.call 'getBadge', {url}, ->
					console.log "Response received"
			else
				instance.error "Repository URL is incorrect"
		else
			instance.warning "Repository isn't set"
