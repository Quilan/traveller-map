# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('.present').click ->
    $.colorbox({
      href: "systems/"+ $(this).attr('id') + "/render_popup"
    })

$(document).on 'click', '#brokers .colorbox', (e) ->
  $.colorbox({
    href: $(this).attr('href')
  })
  e.preventDefault()