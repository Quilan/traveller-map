# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(".present").on "click", (e) ->
    $(this).colorbox({
      href: "systems/"+ $(this).attr('id') + "/render_popup"
      onComplete: ->
        $('.colorbox').colorbox()
      })