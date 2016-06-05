{ Template } = require 'meteor/templating'
{ Repositories } = require '../../imports/api/repositories/collection.coffee'
{ Packages } = require '../../imports/api/packages/collection.coffee'
{ Files } = require '../../imports/api/files/collection.coffee'
{ ReactiveVar } = require 'meteor/reactive-var'
{ _ } = require 'underscore'

Template.details.helpers
  usages: ->
    url = Template.instance().url.get()
    Repositories.findOne({url})?.users or 'no'
  repositoryUrl: ->
    Template.instance().url.get()
  files: ->
    url = Template.instance().url.get()
    packages = Packages.find({url}).fetch()
    _.flatten (
      for pack in packages
        Files.find({packages: pack.name}).fetch()
    )
  getFilePath: (file) ->
    matches = file.url.match /https:\/\/github\.com\/([^\/]+\/[^\/]+)/
    matches[1]
  filesLoading: ->
    not Template.instance().filesHandler.ready()
  noFiles: ->
    Files.find().count() is 0
  hasFiles: ->
    Files.find().count() isnt 0
  hasMoreFiles: ->
    Template.instance().hasMoreFiles.get()

Template.details.onDestroyed ->
  # there is no integrated method for "scrolling pagination" subscription
  @filesHandler.stop()

Template.details.onCreated ->
  path = @data.path()
  url = buildRepositoryUrl path
  @url = new ReactiveVar(url)
  @hasMoreFiles = new ReactiveVar(true)
  @filesCount = new ReactiveVar(0)

  @subscribe('repository', url)

  # Source: http://www.meteorpedia.com/read/Infinite_Scrolling
  $(window).scroll =>
    target = @$("#showMoreResults")
    return if not target.length

    threshold = $(window).scrollTop() + $(window).height() - target.height()

    if target.offset().top < threshold
      if not target.data("visible")
        target.data("visible", true)
        @filesHandler.loadNextPage()
    else if target.data("visible")
      target.data("visible", false)

  @filesHandler = Meteor.subscribeWithPagination('files', url, 100, =>
    current = Files.find().count()
    if current > @filesCount.get()
      @filesCount.set current
    else
      @hasMoreFiles.set false
  )

