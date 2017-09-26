$ ->
  $('body').on 'click', '[data-remote=true]', (event) ->
    $(@).addClass('loading')
