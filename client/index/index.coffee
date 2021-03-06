{ Template } = require 'meteor/templating'
{ FlowRouter } = require 'meteor/kadira:flow-router'
{ ReactiveVar } = require 'meteor/reactive-var'

Template.index.helpers
  path: ->
    Template.instance().getPath()
  insertCode: ->
    path = Template.instance().getPath()
    details = Template.instance().getDetails()
    "[![Mentions](#{path})](#{details})"
  readmeUrl: ->
    "#{Template.instance().url.get()}/blob/master/README.md"
  detailsUrl: ->
    Template.instance().getDetails()

Template.index.onCreated ->
  @path = new ReactiveVar()
  @url = new ReactiveVar()

  @autorun =>
    result = $(".result")

    if @path.get()
      result.fadeIn()
    else
      result.fadeOut()

  @getPath = -> Meteor.absoluteUrl(@path.get()) + ".svg"

  @getDetails = ->
    path = @path.get()
    if path
      [author, repository] = path.split('/')
      FlowRouter.url 'details', {author, repository}

  @clearState = ->
    form = @$(".js-repository-form")
    message = @$(".js-error-message")
    form.removeClass "has-error has-warning"
    message.html ""
    message.hide()

  @warning = (text) ->
    form = @$(".js-repository-form")
    message = @$(".js-error-message")
    form.addClass "has-warning"
    message.html text
    message.show()

  @error = (text) ->
    form = @$(".js-repository-form")
    message = @$(".js-error-message")
    form.addClass "has-error"
    message.html text
    message.show()

Template.index.events
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
