setupOneContainer = ->
  setFixtures " <div data-id='widget-container-1'></div>"

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

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

setupTwitterDisplay = ->
  setupFixtures()
  Twitter.Controller.bind()
  setInputValue('bikes')

clickOn = (element) ->
  $(element).click()

resetWidgetsContainer = ->
  Twitter.Controller.widgets = []

setSandbox = ->
  setFixtures(sandbox())

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

describe "Twitter.Controller", ->
  it "setupWidgetIn displays the twitterForm in the given container", ->
    setFixtures(sandbox())
    Twitter.Controller.setupWidgetIn('#sandbox')
    expect($('#sandbox')).toContainElement('[name=twitter-search]')

  it "widgets container is empty on initialization", ->
    resetWidgetsContainer()
    container = Twitter.Controller.getWidgets()
    expect(container.length).toBe(0)

  it "setupWidgetIn is setting up a widget instance in the desired element", ->
    resetWidgetsContainer()
    setSandbox()
    Twitter.Controller.setupWidgetIn('#sandbox', "123456")
    html = $('#sandbox')
    expect(html).toContainElement('[name=twitter-search]')
    expect(html).toContainElement('[data-id=twitter-button]')
    expect(html).toContainElement('[data-id=twitter-output]')

  it "setupWidgetIn is adding the initialized widget to the widgets container", ->
    resetWidgetsContainer()
    setSandbox()
    Twitter.Controller.setupWidgetIn('#sandbox', "123456")
    expect(Twitter.Controller.getWidgets().length).toEqual(1)

  it "hideForms is hiding the forms of all the widgets that are initialized", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Twitter.Controller.setupWidgetIn(container1, "123456")
    Twitter.Controller.setupWidgetIn(container2, "123456")
    Twitter.Controller.hideForms()
    expect($("#{container1} [data-id=twitter-form]").attr('style')).toEqual('display: none;')
    expect($("#{container2} [data-id=twitter-form]").attr('style')).toEqual('display: none;')

  it "showForms is showing the forms of all the widgets that are initialized", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Twitter.Controller.setupWidgetIn(container1, "123456")
    Twitter.Controller.setupWidgetIn(container2, "123456")
    Twitter.Controller.hideForms()
    Twitter.Controller.showForms()
    expect($("#{container1} [data-id=twitter-form]").attr('style')).not.toEqual('display: none;')
    expect($("#{container2} [data-id=twitter-form]").attr('style')).not.toEqual('display: none;')

  it "closeWidgetInContainer will eliminate the widget from the given container", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Twitter.Controller.setupWidgetIn(container1, "123456")
    Twitter.Controller.setupWidgetIn(container2, "123456")
    Twitter.Controller.closeWidgetInContainer(container1)
    expect($("#{container1} [data-id=twitter-form]")).not.toBeInDOM()
    expect($("#{container2} [data-id=twitter-form]")).toBeInDOM()

  it "closeWidgetInContainer will remove the widget from the widgets container", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Twitter.Controller.setupWidgetIn(container1, "123456")
    Twitter.Controller.setupWidgetIn(container2, "123456")
    Twitter.Controller.closeWidgetInContainer(container1)
    expect(Twitter.Controller.getWidgets().length).toEqual(1)

  it "allWidgetsExecute is removing the inactive widgets", ->
    resetWidgetsContainer()
    setupTwoContainers()
    Twitter.Controller.setupWidgetIn(container1, "123456")
    Twitter.Controller.setupWidgetIn(container2, "123456")
    Twitter.Controller.widgets[0].setAsInactive()
    Twitter.Controller.allWidgetsExecute('hideForm')
    expect(Twitter.Controller.widgets.length).toBe(1)

