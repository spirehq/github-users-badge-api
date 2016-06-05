{ FlowRouter } = require 'meteor/kadira:flow-router'
{ BlazeLayout } = require 'meteor/kadira:blaze-layout'

router = FlowRouter.group()

router.route "/",
	name: "index"
	action: ->
		BlazeLayout.render "layout",
			main: "index"

router.route "/:author/:repository",
	name: "details"
	action: ({author, repository}) ->
		BlazeLayout.render "layout",
			main: "details"
			path: "#{author}/#{repository}"
