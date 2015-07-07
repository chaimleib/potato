# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this
root.formatters = new Object
root.formatters.common = common = new Object
root.formatters.propagations = propagations = new Object

baseUri = location.protocol + '//' + location.host + location.pathname
jiraUriBase = document.context.jira_host + '/browse/'
 
common.relDueDate = (dateString) ->
	date = new Date(dateString)
	now = new Date
	iso = strftime('%Y-%m-%dT%H:%M:%S.%L%z', date)
	friendly = strftime('%A, %B %-d, %Y %-I:%M %P %z', date)
	timeClasses = ['timeago', 'due']
	if date < now
		timeClasses.push 'urgent'

	tag = document.createElement('time')
	tag.setAttribute('class', timeClasses.join(' '))
	tag.setAttribute('datetime', iso)
	tag.setAttribute('title', friendly)
	tag.setAttribute('data-time-ago', iso)
	tag.innerHTML = friendly
	return tag.outerHTML

common.jiraIssue = (key) ->
	tag = document.createElement('a')
	escapedKey = encodeURIComponent(key)
	tag.setAttribute('href', jiraUriBase + escapedKey)
	tag.innerHTML = key.replace('-', '&#8209;')
	return tag.outerHTML

common.pr = (pr) ->
	# pr is an object with keys 'key', 'uri', and 'time'
	tag = document.createElement('a')
	tag.setAttribute('href', pr.uri)
	tag.innerHTML = pr.key.replace('-', '&#8209;')
	return tag.outerHTML

common.prs = (prs) ->
	# prs is not a string; it's an array of objects
	if !prs or prs.length == 0
		return '-'
	prs = prs.sort (a, b) ->
		aDate = new Date(a.date)
		bDate = new Date(b.date)
		return -1 if aDate < bDate
		return 1 if aDate > bDate
		return 0
	links = prs.map(common.pr).join(' ')
	return links

propagations.user = (userString) ->
	escapedUser = encodeURIComponent(userString)
	params = "?utf8=%E2%9C%93&user=" + escapedUser
	uri = baseUri + params
	tag = document.createElement('a')
	tag.setAttribute('href', uri)
	tag.innerHTML = userString
	return tag.outerHTML

