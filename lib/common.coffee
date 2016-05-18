@validateRepositoryUrl = (url) ->
	@resolveRepositoryUrl(url) isnt false

@resolveRepositoryUrl = (link) ->
	matches = link.match /(https:\/\/github\.com\/[^/]+\/[^/]+)/
	return false if not matches

	url = matches[1]
	#url = url.substr(0, url.length - 4) if url.match(/\.git$/)
	url

@resolvePath = (url) ->
	matches = url.match /https:\/\/github\.com\/([^/]+\/[^/]+)/
	return false if not matches
	matches[1]

@buildRepositoryUrl = (path) ->
	"https://github.com/" + path
