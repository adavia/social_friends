# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Attachment
  constructor: (el) ->
    @el = $(el)

  upload: ->
    @el.ajaxSubmit
      url: @el.attr("action")
      type: "POST"
      dataType: "script"
      data: @el.serialize()
      beforeSend: (jqXHR) =>
        token = $('meta[name="csrf-token"]').attr("content")
        jqXHR.setRequestHeader "X-CSRF-Token", token
      complete: (jqXHR, textStatus) =>
        @toggleButton(false, "Submit")

  toggleButton: (status, text) ->
    button = @el.find($('input[name="commit"]'))
    button.prop("disabled", status)
    button.val(text)

  previewImages: ->
    if typeof FileReader != "undefined"
      dvPreview = $("#img-holder")
      dvPreview.html("")
      regex = /^([a-zA-Z0-9\s_\\.\-:])+(.jpg|.jpeg|.gif|.png|.bmp)$/
      $(@el[0].files).each ->
        file = $(@)
        if regex.test(file[0].name.toLowerCase())
          reader = new FileReader
          reader.onload = (e) ->
            img = $("<img />")
            img.attr "style", "height:100px;width: 100px"
            img.attr "src", e.target.result
            dvPreview.append img
          reader.readAsDataURL file[0]
        else
          alert file[0].name + " is not a valid image file."
          dvPreview.html ""
    else
      alert "This browser does not support HTML5 FileReader."

$(document).on "change", "input[type='file']", (event) ->
  return unless $(".attachments.index").length > 0
  attach = new App.Attachment @
  attach.previewImages()

$(document).on "submit", "[data-behavior~=new-attachment]", (event) ->
  return unless $(".attachments.index").length > 0
  event.preventDefault()
  attach = new App.Attachment @
  attach.toggleButton(true, "Submitting..")
  attach.upload()
