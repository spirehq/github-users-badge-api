{ Template } = require 'meteor/templating'
{ FlowRouter } = require 'meteor/kadira:flow-router'
{ ReactiveVar } = require 'meteor/reactive-var'

Template.getBadge.helpers
	path: ->
		Template.instance().getPath()
	insertCode: ->
		path = Template.instance().getPath()
		details = Template.instance().getDetails()
		"[![Mentions](#{path})](#{details})"
	readmeUrl: ->
		"#{Template.instance().url.get()}/blob/master/README.md"

Template.getBadge.onCreated ->
	@path = new ReactiveVar()
	@url = new ReactiveVar()

	@autorun =>
		result = $(".result")

		if @path.get()
			result.fadeIn()
		else
			result.fadeOut()

	@getPath = -> Meteor.absoluteUrl(@path.get()) + ".svg"
	@getDetails = -> Meteor.absoluteUrl(@path.get()) + "/details"

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
				path = resolvePath url
				instance.url.set url
				instance.path.set path
			else
				instance.path.set undefined
				instance.error "Repository URL is incorrect"
		else
			instance.path.set undefined 
			instance.warning "Repository isn't set"
