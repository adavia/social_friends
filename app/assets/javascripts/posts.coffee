# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class App.Post
  constructor: (el) ->
    @el = $(el)

  submit: ->
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

  fancybox: ->
    $("a.fancy-post").fancybox({ parent: "body"})

$(document).on "change", "input[type='file']", (event) ->
  return unless $(".posts.index").length > 0
  post = new App.Attachment @
  post.previewImages()

$(document).on "submit", "[data-behavior~=submit-post]", (event) ->
  return unless $(".posts.index").length > 0 or $(".profiles.show").length > 0
  event.preventDefault()
  post = new App.Post @
  post.toggleButton(true, "Publishing..")
  post.submit()

$(document).on "page:change", ->
  return unless $(".posts.index").length > 0 or $(".profiles.show").length > 0
  post = new App.Post
  post.fancybox()