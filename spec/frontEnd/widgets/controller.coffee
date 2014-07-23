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

newController = (container) ->
  new Twitter.Widgets.Controller(container, "1243")

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
