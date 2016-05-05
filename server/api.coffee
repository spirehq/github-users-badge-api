url = require "url"
request = require "request"
{Repositories} = require "/imports/api/repositories/collection"

calculations =
  "https://github.com/kissjs/node-mongoskin": 3292

#connect = Npm.require("connect")
#
#Fiber = Npm.require("fibers")

WebApp.connectHandlers.use (req, res, next) ->
  return next() unless req.url.match(/\.svg$/)
  parts = url.parse(req.url)
  pathname = parts.pathname.replace(".svg", "")
  splinters = pathname.split("/")
  return next() unless splinters.length is 3 and splinters[1] and splinters[2]
  repositoryUrl = "https://github.com/#{splinters[1]}/#{splinters[2]}"
  if calculations[repositoryUrl]
    count = calculations[repositoryUrl]
  else
    repository = Repositories.findOne({url: repositoryUrl})
    count = repository?.users or encodeURIComponent("?")
  request.get("https://img.shields.io/badge/mentions-#{count}-brightgreen.svg").pipe(res)
