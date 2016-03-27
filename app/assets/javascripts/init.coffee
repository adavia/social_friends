window.App ||= {}

App.init = ->
  $("a.fancybox").fancybox 
    parent: "body"
    beforeLoad: ->
      url = $(@element).attr("href")
      this.href = url
    type: 'ajax'

$(document).on "page:change", ->
  App.init()