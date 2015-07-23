# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = this

root.potato = new Object
getThrobber = (id) ->
  if root.potato.throbber
    return root.potato.throbber
  img = document.createElement('img')
  img.setAttribute('src', '/assets/throbber.gif')
  img.setAttribute('alt', 'loading...')
  img.setAttribute('class', 'throbber')
  root.potato.throbber = img
  return root.potato.throbber
$(-> getThrobber())
$(document).on('pre-body.bs.table', (event)->
	$('.fixed-table-loading').html('Loading, please wait...<img src="/assets/table-throbber.gif" style="display: inline; position: relative; bottom: 2px;">')
)
### FORMATTERS ###
root.formatters = new Object
root.formatters.common = common = new Object
root.formatters.propagations = propagations = new Object
root.formatters.due_dates = due_dates = new Object

baseUri = location.protocol + '//' + location.host + location.pathname
if document.context
	jiraUriBase = document.context.jira_host
	jiraIssueUriBase = jiraUriBase + '/browse/'
	jiraSessionUri = jiraUriBase + '/rest/auth/1/session'

# common.show = (url) ->
# 	if url[-5..] == '.json'
# 		url = url[0...-5]
# 	tag = document.createElement('a')
# 	tag.setAttribute('href', url)
# 	tag.innerHTML = 'Show'
# 	return tag.outerHTML

# common.edit = (url) ->
# 	if url[-5..] == '.json'
# 		url = url[0...-5]
# 	url += '/edit'
# 	tag = document.createElement('a')
# 	tag.setAttribute('href', url)
# 	tag.innerHTML = 'Edit'
# 	return tag.outerHTML

# common.destroy = (url) ->
# 	# TODO: This is triggering the dialog twice under dev env
# 	if url[-5..] == '.json'
# 		url = url[0...-5]
# 	tag = document.createElement('a')
# 	tag.setAttribute('href', url)
# 	tag.setAttribute('data-method', 'delete')
# 	tag.setAttribute('data-confirm', 'Are you sure?')
# 	tag.innerHTML = 'Destroy'
# 	return tag.outerHTML

common.relDueDate = (dateString) ->
	if not dateString
		return "N/A"
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
	tag.setAttribute('href', jiraIssueUriBase + escapedKey)
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

propagations.targetVersion = (version, row) ->
	due = new Date(row.due)
	now = new Date
	isUrgent = row.due && due < now
	unless isUrgent
		return version
	tag = document.createElement('span')
	tag.setAttribute('class', 'urgent')
	tag.innerHTML = version
	return tag.outerHTML

due_dates.due = (dueField) ->
	$due = $(dueField)
	$due.text($.trim($due.text()))
	due_ref_name = $due.attr('data-ref-name')
	if !due_ref_name
		return $due.prop('outerHTML')
	due_ref_link = $due.attr('data-ref-link')

	$result = $('<div>', {class: "strong grey"})
	$result.append($('<a>', {href: due_ref_link, text: due_ref_name}))
	$result.append('&rarr;')
	$result.append($due)
	return $result.prop('outerHTML')

### SORTERS ###
# root.sorters = new Object
# root.sorters.due_dates = due_dates = new Object
# parseDate = (dateString) ->
# 	parts = dateString.split('/')
# 	new Date(parts[2] + '-' + parts[0] + '-' + parts[1])
# dateRgx = new RegExp('')
# due_dates.due = (a, b) ->
# 	dateA = ''
