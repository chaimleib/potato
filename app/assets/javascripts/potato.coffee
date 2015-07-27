# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

root = this
root.potato = new Object

root.potato.elements = elements = new Object
elements.throbber = ->
  img = $('<img>', {
    src: '/assets/throbber.gif',
    alt: 'loading...',
    class: 'throbber'
  })
  return img
elements.tableThrobber = ->
  img = $('<img>', {
    src: '/assets/table-throbber.gif',
    alt:'loading...',
    class:'table-throbber'
  })
  return img

preload = $('body').
  append('<div>', {id:"preload", style:"display:none;"}).
  append(elements.throbber()).
  append(elements.tableThrobber())
$(document).on('page:change', -> # page:change is for turbolinks
  preload.remove()
)

$(document).on('pre-body.bs.table', (event)->
  $('#content .fixed-table-loading').html(elements.tableThrobber())
    #'Loading, please wait...<img src="/assets/table-throbber.gif" style="display: inline; position: relative; bottom: 2px;">')
)
### FORMATTERS ###
root.potato.formatters = new Object
root.potato.formatters.common = common = new Object
root.potato.formatters.propagations = propagations = new Object
root.potato.formatters.due_dates = due_dates = new Object

baseUri = location.protocol + '//' + location.host + location.pathname
if document.context
  jiraUriBase = document.context.jira_host
  jiraIssueUriBase = jiraUriBase + '/browse/'
  jiraSessionUri = jiraUriBase + '/rest/auth/1/session'

# common.show = (url) ->
#   if url[-5..] == '.json'
#     url = url[0...-5]
#   tag = document.createElement('a')
#   tag.setAttribute('href', url)
#   tag.innerHTML = 'Show'
#   return tag.outerHTML

# common.edit = (url) ->
#   if url[-5..] == '.json'
#     url = url[0...-5]
#   url += '/edit'
#   tag = document.createElement('a')
#   tag.setAttribute('href', url)
#   tag.innerHTML = 'Edit'
#   return tag.outerHTML

# common.destroy = (url) ->
#   # TODO: This is triggering the dialog twice under dev env
#   if url[-5..] == '.json'
#     url = url[0...-5]
#   tag = document.createElement('a')
#   tag.setAttribute('href', url)
#   tag.setAttribute('data-method', 'delete')
#   tag.setAttribute('data-confirm', 'Are you sure?')
#   tag.innerHTML = 'Destroy'
#   return tag.outerHTML

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
  links = prs.map(potato.formatters.common.pr).join(' ')
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
root.potato.sorters = new Object
root.potato.sorters.common = common = new Object
root.potato.sorters.due_dates = due_dates = new Object
cmp = (a, b) ->
  if a > b then return 1
  if a < b then return -1
  return 0

chunkRgx = /(_+)|([0-9]+)|([^0-9_]+)/g
naturalCmp = (a, b) ->
  # Thanks, @georg on stackoverflow.com!
  # http://stackoverflow.com/questions/15478954/sort-array-elements-string-with-numbers-natural-sort
  ax = []
  bx = []
  a.replace(chunkRgx, (_, $1, $2, $3) -> ax.push([$1 || "0", $2 || Infinity, $3 || ""]) )
  b.replace(chunkRgx, (_, $1, $2, $3) -> bx.push([$1 || "0", $2 || Infinity, $3 || ""]) )
  while(ax.length && bx.length)
    an = ax.shift()
    bn = bx.shift()
    nn = an[0].localeCompare(bn[0]) || (an[1] - bn[1]) || an[2].localeCompare(bn[2])
    if nn then return nn
  return ax.length - bx.length

common.branchName = (a, b) ->
  naturalCmp(a, b)
  
due_dates.due = (a, b) ->
  $a = $('<div>').append(a).find('time')
  $b = $('<div>').append(b).find('time')

  dateA = $a.attr('datetime')
  dateB = $b.attr('datetime')
  if dateA > dateB then return 1
  if dateA < dateB then return -1
  nameA = $a.attr('data-ref-name')
  nameB = $b.attr('data-ref-name')
  if nameA && !nameB then return -1
  if !nameA && nameB then return 1
  return cmp(nameA, nameB)
