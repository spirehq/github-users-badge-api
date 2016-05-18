{ FlowRouter } = require 'meteor/kadira:flow-router'
{ BlazeLayout } = require 'meteor/kadira:blaze-layout'

router = FlowRouter.group()

router.route "/",
	name: "getBadge"
	action: ->
		BlazeLayout.render "layout",
			main: "getBadge"

router.route "/:author/:repository",
	name: "details"
	action: ->
		BlazeLayout.render "layout",
			main: "details"
