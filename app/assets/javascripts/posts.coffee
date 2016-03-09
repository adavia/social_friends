# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Post
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
        @toggleButton(false, "Publish")

  toggleButton: (status, text) ->
    button = @el.find($('input[name="commit"]'))
    button.prop("disabled", status)
    button.val(text)

  previewImages: ->
    img_holder = $("#img-holder")
    img_holder.empty()

    count_files = @el[0].files.length
    path = @el[0].value
    ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase()

    if ext == "gif" or ext == "png" or ext == "jpg" or ext == "jpeg"
      if typeof FileReader != "undefined"
        i = 0
        while i < count_files
          reader = new FileReader
          reader.onload = (e) ->
            $("<img />",
              "src": e.target.result
              "class": "img-thumbnail img-responsive").appendTo img_holder

          img_holder.show()
          reader.readAsDataURL @el[0].files[i]
          i++
      else
        console.log 'This browser does not support FileReader.'
    else
      console.log 'Pls select only images'

$(document).on "page:change", ->
  return unless $(".posts.index").length > 0
  $(document).on "submit", "[data-behavior~=new-post]", (event) ->
    event.preventDefault()
    post = new App.Post @
    post.toggleButton(true, "Publishing..")
    post.upload()

  $(document).on "change", "input[type='file']", (event) ->
    post = new App.Post @
    post.previewImages()