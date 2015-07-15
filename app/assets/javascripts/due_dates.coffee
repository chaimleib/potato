# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(() ->
  getThrobber = (id) ->
    img = document.createElement('img')
    img.setAttribute('src', '/assets/throbber.gif')
    img.setAttribute('alt', 'loading...')
    img_div = document.createElement('div')
    img_div.setAttribute('id', id)
    img_div.setAttribute('class', 'icon-container')
    img_div.innerHTML = img.outerHTML
    return img_div
  throbber = getThrobber()
  $('#wiki-btn').click(() -> 
    btn = $('#wiki-btn')
    btn.setAttribute('disabled', 'true')
    btn.insertAfter(throbber)
  )
)
