namespace("Twitter.Widgets")

class Twitter.Widgets.Controller
  apiKey = undefined
  constructor: (settings) ->
    apiKey = settings.key
    @container = settings.container
    @display = new Twitter.Widgets.Display(@container, settings.animationSpeed)
    @defaultValue = settings.defaultValue
    @setAsInactive()
    @refreshRate  = settings.refreshRate

  initialize: ->
    @display.setupWidget()
    @bind()
    @displayDefault()
    @setAsActive()

  displayDefault: ->
    if @defaultValue
      @getTwitterPosts(@defaultValue)

  setAsActive: ->
    @activeStatus = true

  setAsInactive: ->
    @activeStatus = false

  isActive: ->
    @activeStatus

  bind: ->
    $("#{@container} [data-name=widget-form]").on 'submit',(e) =>
      e.preventDefault()
      @processClickedButton()
    $("#{@container} [data-name=widget-close]").click => @closeWidget()

  processClickedButton: ->
    input = @display.getInput()
    @getTwitterPosts(input)

  getTwitterPosts: (input) ->
    Twitter.Widgets.API.getPosts(input, @display)
    if @refreshRate
      @clearActiveTimeout()
      @refreshImages(input)

   clearActiveTimeout: ->
     clearTimeout(@timeout) if @timeout

   refreshImages: (searchStr) ->
     @timeout = setTimeout(=>
       @getTwitterPosts(searchStr) if @isActive()
     , @refreshRate * 1000)

  closeWidget: ->
    @unbind()
    @removeContent()
    @setAsInactive()

  removeContent: ->
    @display.removeWidget()

  unbind: ->
    $("#{@container} [data-name=widget-form]").unbind('submit')
    $("#{@container} [data-name=widget-close]").unbind('click')
