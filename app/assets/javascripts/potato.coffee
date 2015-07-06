# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = exports ? this

root.relDueDateFormatter = (dateString) ->
	date = new Date(dateString)
	now = new Date
	iso = strftime('%Y-%m-%dT%H:%M:%S.%L%z', date)
	friendly = strftime('%A, %B %-d, %Y %-I:%M %P %z', date)
	timeClasses = ['timeago', 'due']
	if date < now
		timeClasses.push 'urgent'

	tagParts = [
		"<time class=\"",
		timeClasses.join(' '),
		"\" datetime=\"",
		iso,
		"\" title=\"",
		friendly,
		"\" data-time-ago=\"",
		iso,
		"\">",
		friendly,
		"</time>"
	]

	tag = tagParts.join('')
	return tag
