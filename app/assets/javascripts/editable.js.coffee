$ ->
  $.fn.editable.defaults.ajaxOptions =
    type: 'PATCH'
    dataType: 'script'
    headers:
      'X-CSRF-TOKEN': document.head.querySelector("[name=csrf-token]").content

  $(".editable").not("[data-pk]").editable
    ajaxOptions:
      type: 'POST'
      dataType: 'script'
      headers:
        'X-CSRF-TOKEN': document.head.querySelector("[name=csrf-token]").content

  $("[data-toggle-editable]").click ->
    e = $(@)
    if e.hasClass('active')
      e.removeClass('active')
      $(e.data('toggle-editable')).editable('disable')
    else
      e.addClass('active')
      $(e.data('toggle-editable')).editable('enable')
