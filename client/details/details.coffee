{ Template } = require 'meteor/templating'
{ Repositories } = require '../../imports/api/repositories/collection.coffee'
{ Packages } = require '../../imports/api/packages/collection.coffee'
{ Files } = require '../../imports/api/files/collection.coffee'
{ ReactiveVar } = require 'meteor/reactive-var'
{ _ } = require 'underscore'

Template.details.helpers
	usages: ->
		url = Template.instance().url.get()
		Repositories.findOne({url})?.users or 0
	repositoryUrl: ->
		Template.instance().url.get()
	files: ->
		url = Template.instance().url.get()
		packages = Packages.find({url}).fetch()
		_.flatten (
			for pack in packages
				Files.find({packages: pack.name}).fetch()
		)

Template.details.onCreated ->
	path = @data.path()
	url = buildRepositoryUrl path
	@url = new ReactiveVar(url)

	@subscribe('repository', url)
	@subscribe('files', url)
