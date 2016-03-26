window.App ||= {}

App.init = ->
  $("a.fancybox").fancybox({ parent: "body"})

$(document).on "page:change", ->
  App.init()