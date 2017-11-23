$ ->
  $("[data-toggle=collapse]").on 'click', ->
    e = $(@)
    if e.hasClass('active')
      e.removeClass('active')
    else
      e.addClass('active')
