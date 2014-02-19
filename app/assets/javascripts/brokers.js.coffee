# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


purchase_mods = [4.00, 3.00, 2.00, 1.75, 1.50, 1.35, 1.25, 1.20, 1.15, 1.10, 1.05, 1.00, 0.95, 0.90, 0.85, 0.80, 0.75, 0.70, 0.65, 0.55, 0.50, 0.40, 0.25]

sale_mods = [0.25, 0.45, 0.50, 0.55, 0.60, 0.65, 0.75, 0.80, 0.85, 0.90, 0.95, 1.00, 1.05, 1.10, 1.15, 1.20, 1.25, 1.35, 1.50, 1.75, 2.00, 3.00, 4.00]

$(document).ready ->
  $(document).on 'click', '.toggle', (e) ->
    if (!$(this).hasClass('active'))
      $('.toggle').each ->
        $(this).toggleClass('active')
        $($(this).attr('href')).toggle()
    e.preventDefault()
    $.colorbox.resize()

  $(document).on 'change', 'thead .quantity :input', ->
    $(this).closest('table').find('tbody tr').each ->
      $(this).find('.quantity :input').first().change()
  $(document).on 'change', 'tbody .quantity :input', ->
    row = $(this).closest('tr')
    qty = row.find('[name=quantity]').val()
    mod = row.find('[name=roll]').val()
    price = parseInt(row.find('.price').html().replace(/[^\d]/g,''))
    dice_mod = 1
    if mod.length && qty.length
      modVal = parseInt(mod)
      modVal = -1 if modVal < -1
      modVal = 21 if modVal > 21
      if $('#kind').val() == 'purchase'
        dice_mod = purchase_mods[modVal + 1]
      else
        dice_mod = sale_mods[modVal + 1]

      subtotal = parseInt(qty) * price * dice_mod
      row.find('.total').html(formatNumber(subtotal) + " cr")
    else
      row.find('.total').html("&nbsp;")

    total = 0
    $('tbody .total').each ->
      subtotal = parseInt($(this).html().replace(/[^\d]/g,''))
      if subtotal
        total += subtotal

    $('tfoot .total').html(formatNumber(total) + ' cr')


formatNumber = (nStr) ->
  nStr += ''
  x = nStr.split('.')
  x1 = x[0]
  x2 = if (x.length > 1) then ('.' + x[1]) else ''
  rgx = /(\d+)(\d{3})/
  while rgx.test(x1)
    x1 = x1.replace(rgx, '$1' + ',' + '$2')

  return x1 + x2
