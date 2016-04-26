url = require "url"
request = require "request"
{ Repositories } = require "/imports/api/repositories/collection"

#connect = Npm.require("connect")
#
#Fiber = Npm.require("fibers")

WebApp.connectHandlers
  .use (req, res, next) ->
    parts = url.parse(req.url)
    console.log parts
    splinters = parts.pathname.split("/")
    console.log splinters
    return next() unless splinters.length is 3 and splinters[1] and splinters[2]
    repositoryUrl = "https://github.com/#{splinters[1]}/#{splinters[2]}"
    repository = Repositories.findOne({url: repositoryUrl})
    count = repository?.users or encodeURIComponent("?")
    request.get("https://img.shields.io/badge/users-#{count}-brightgreen.svg").pipe(res)
