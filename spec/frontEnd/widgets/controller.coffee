container     = "[data-id=widget-container-1]"
key           = "1243"
defaultValue  = "bikes"

setInputValue = (value) ->
  $('[name=twitter-search]').val(value)

clickButton = (container) ->
  $("#{container} [data-id=twitter-button]").click()

twitterResponse = [
  {
    text: "Some Text"
  },
  {
    text: "Other text"
  },
  {
    text: "Third text"
  }
]

getJsonObject = ->
  JSON.stringify(twitterResponse)

setupOneContainer = ->
  setFixtures "<div data-id='widget-container-1'></div>"

container = "[data-id=widget-container-1]"

newController = (container, value) ->
  new Twitter.Widgets.Controller(container, key, value)

describe "Twitter.Widgets.Controller", ->
  it "stores the container that it is initialized with", ->
    controller = newController(container)
    expect(controller.getContainer()).toEqual(container)

  it "stores a new instance of Twitter.Widget.Display when instantiated", ->
    controller = newController(container)
    expect(controller.display).toBeDefined()

  it "initialize sets widget up in its container", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    expect($(container)).not.toBeEmpty()

  it "initialize is binding the controller", ->
    controller = newController(container)
    spy = spyOn(controller, 'bind')
    controller.initialize()
    expect(spy).toHaveBeenCalled()

  it "initialize is trying to display data for the default value", ->
    controller = newController(container)
    spy = spyOn(controller, 'displayDefault')
    controller.initialize()
    expect(spy).toHaveBeenCalled()

  it "initialize is setting the widget as active", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    expect(controller.isActive()).toBe(true)

  it "displayDefault is loading data when there is a default value", ->
    controller = newController(container, defaultValue)
    spy = spyOn(Twitter.Widgets.API, 'getPosts')
    controller.displayDefault()
    expect(spy).toHaveBeenCalledWith(defaultValue, controller.display)

  it "displayDefault doesn't do anything when no default value is provided", ->
    controller = newController(container)
    spy = spyOn(Twitter.Widgets.API, 'getPosts')
    controller.displayDefault()
    expect(spy).not.toHaveBeenCalled()

  it "bind displays tweets with the search input when twitter button is clicked", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    server = sinon.fakeServer.create()
    server.respondWith(/.+/, getJsonObject())
    clickButton(container)
    server.respond()
    twitterOutput = $("#{container} [data-id=twitter-output]")
    expect(twitterOutput).toContainText("Some Text")
    expect(twitterOutput).toContainText("Other text")
    expect(twitterOutput).toContainText("Third text")
    server.restore()

  it "bind removes the widget when close-widget button is clicked", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    $("#{container} [data-id=twitter-close]").click()
    expect(container).not.toBeInDOM()

  it 'unbind is unbinding the twitter button click processing', ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.unbind()
    $("#{container} [data-id=twitter-button]").click()
    expect($('[data-id=twitter-output]')).toBeEmpty()

  it "unbind is unbinding close widget button processing", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.unbind()
    $("#{container} [data-id=twitter-close]").click()
    expect($(container)).not.toBeEmpty()

  it 'closeWidget is unbinding the controller', ->
    setupOneContainer()
    controller = newController(container)
    spy = spyOn(controller, 'unbind')
    controller.closeWidget()
    expect(spy).toHaveBeenCalled()

  it 'closeWidget is setting the widget as inactive', ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.closeWidget()
    expect(controller.isActive()).toBe(false)

  it "hideForm is hiding the form", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.hideForm()
    expect($("#{container} [data-id=twitter-form]").attr('style')).toEqual('display: none;')

  it "showForm is showing the form", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.hideForm()
    controller.showForm()
    expect($("#{container} [data-id=twitter-form]").attr('style')).not.toEqual('display: none;')

  it "removeContent is removing the widget's content", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.removeContent()
    expect($(container)).not.toContainElement("[data-id=twitter-widget-wrapper]")
