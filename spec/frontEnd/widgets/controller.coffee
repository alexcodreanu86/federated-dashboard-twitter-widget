container     = "[data-id=widget-container-1]"
defaultValue  = "bikes"

twitterResponse = [
  {
    "text": "Some Text",
    "user": {
      "profile_image_url": "mockImg/001.jpeg",
      "name": "One"
    }
  },
  {
    "text": "Other text",
    "user": {
      "profile_image_url": "mockImg/002.jpeg",
      "name": "Two"
    }
  },
  {
    "text": "Third text",
    "user": {
      "profile_image_url": "mockImg/003.jpeg",
      "name": "Three"
    }
  }
]

getJsonObject = ->
  JSON.stringify(twitterResponse)

setupOneContainer = ->
  setFixtures "<div data-id='widget-container-1'></div>"

container = "[data-id=widget-container-1]"

newController = (container, value) ->
  new Twitter.Widgets.Controller({container: container, defaultValue: value})

describe "Twitter.Widgets.Controller", ->
  it "stores the container that it is initialized with", ->
    controller = newController(container)
    expect(controller.container).toEqual(container)

  it "stores a new instance of Twitter.Widget.Display when instantiated", ->
    controller = newController(container)
    expect(controller.display).toBeDefined()

  describe "#initialize", ->
    it "sets widget up in its container", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      expect($(container)).not.toBeEmpty()

    it "binds the controller", ->
      controller = newController(container)
      spy = spyOn(controller, 'bind')
      controller.initialize()
      expect(spy).toHaveBeenCalled()

    it "tries to display data for the default value", ->
      controller = newController(container)
      spy = spyOn(controller, 'displayDefault')
      controller.initialize()
      expect(spy).toHaveBeenCalled()

    it "sets the widget as active", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      expect(controller.isActive()).toBe(true)

  describe "#displayDefault", ->
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

  describe '#bind', ->
    it "displays tweets with the search input when twitter button is clicked", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      server = sinon.fakeServer.create()
      server.respondWith(/.+/, getJsonObject())
      $('[data-name=form-button]').click()
      server.respond()
      twitterOutput = $("#{container} [data-name=widget-output]")
      expect(twitterOutput).toContainText("Some Text")
      expect(twitterOutput).toContainText("Other text")
      expect(twitterOutput).toContainText("Third text")
      server.restore()

    it "removes the widget when close-widget button is clicked", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      $("[data-name=widget-close]").click()
      expect(container).not.toBeInDOM()

  describe '#unbind', ->
    it 'unbind is unbinding the form submit', ->
      controller = newController(container)
      spy = spyOn $.prototype, 'unbind'
      controller.unbind()
      expect(spy).toHaveBeenCalledWith('submit')

    it "unbind is unbinding close widget button processing", ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      controller.unbind()
      $("[data-name=widget-close]").click()
      expect($(container)).not.toBeEmpty()

  describe '#closeWidget', ->
    it 'unbinds the controller', ->
      setupOneContainer()
      controller = newController(container)
      spy = spyOn(controller, 'unbind')
      controller.closeWidget()
      expect(spy).toHaveBeenCalled()

    it 'sets the widget as inactive', ->
      setupOneContainer()
      controller = newController(container)
      controller.initialize()
      controller.closeWidget()
      expect(controller.isActive()).toBe(false)


  it "removeContent is removing the widget's content", ->
    setupOneContainer()
    controller = newController(container)
    controller.initialize()
    controller.removeContent()
    expect($(container)).not.toContainElement("[data-id=twitter-widget-wrapper]")

  describe "refresh Rate", ->
    newRefreshController = (container, refreshRate) ->
      new Twitter.Widgets.Controller({container: container, refreshRate: refreshRate})

    oneMinute   = 60 * 1000
    controller  = undefined
    spy         = undefined

    beforeEach ->
      controller = newRefreshController(container, 50)
      controller.setAsActive()
      spy = spyOn(Twitter.Widgets.API, 'getPosts')
      jasmine.clock().install()

    afterEach ->
      jasmine.clock().uninstall()

    it "refreshes information when refreshRate is provided", ->
      controller.getTwitterPosts('some input')
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(2)

    it "will not refresh if the widget is closed", ->
      controller.getTwitterPosts('some input')
      expect(spy.calls.count()).toEqual(1)
      controller.closeWidget()
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(1)

    it "will not refresh if no refreshRate is specified", ->
      controller = newRefreshController(container, undefined)
      controller.setAsActive()
      controller.getTwitterPosts('some input')
      expect(spy.calls.count()).toEqual(1)
      jasmine.clock().tick(oneMinute)
      expect(spy.calls.count()).toEqual(1)

