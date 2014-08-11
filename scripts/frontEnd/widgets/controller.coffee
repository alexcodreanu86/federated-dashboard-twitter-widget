namespace("Twitter.Widgets")

class Twitter.Widgets.Controller
  apiKey = undefined
  constructor: (settings) ->
    apiKey = settings.key
    @container = settings.container
    @display = new Twitter.Widgets.Display(@container)
    @defaultValue = settings.defaultValue
    @setAsInactive()

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


  getContainer: ->
    @container

  bind: ->
    $("#{@container} [data-id=twitter-button]").click(=> @processClickedButton())
    $("#{@container} [data-id=twitter-close]").click(=> @closeWidget())

  processClickedButton: ->
    input = @display.getInput()
    @getTwitterPosts(input)

  getTwitterPosts: (input) ->
    Twitter.Widgets.API.getPosts(input, @display)

  closeWidget: ->
    @unbind()
    @removeContent()
    @setAsInactive()

  removeContent: ->
    @display.removeWidget()

  unbind: ->
    $("#{@container} [data-id=stock-button]").unbind('click')
    $("#{@container} [data-id=stock-close]").unbind('click')

  hideForm: ->
    @display.exitEditMode()

  showForm: ->
    @display.enterEditMode()

