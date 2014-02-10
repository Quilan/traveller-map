# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(document).on 'click', '.toggle', (e) ->
    if (!$(this).hasClass('active'))
      $('.toggle').each ->
        $(this).toggleClass('active')
        $($(this).attr('href')).toggle()
    e.preventDefault()
    $.colorbox.resize()