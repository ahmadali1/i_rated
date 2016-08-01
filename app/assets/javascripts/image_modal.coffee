show_modal = ->
  $('.item').on 'click', ->
    $('.imagepreview').attr 'src', $(this).find('img').attr('src')
    $('#imagemodal').modal 'show'

(($) ->
  window.ImageModal || (window.ImageModal = {})

  ImageModal.init = ->
    init_controls()

  init_controls = ->
    show_modal()
).call(this)
