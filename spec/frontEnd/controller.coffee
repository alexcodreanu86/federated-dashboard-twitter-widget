resetWidgetsContainer = ->
  Twitter.Controller.widgets = []

setSandbox = ->
  setFixtures(sandbox())

setupTwoWidgetsInContainers = ->
  setupTwoContainers()
  setupWidgetInContainer(container1)
  setupWidgetInContainer(container2)

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

setupWidgetInContainer = (container) ->
  Twitter.Controller.setupWidgetIn({container: container})

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

describe "Twitter.Controller", ->
  it "widgets container is empty on initialization", ->
    resetWidgetsContainer()
    container = Twitter.Controller.getWidgets()
    expect(container.length).toBe(0)

  it "setupWidgetIn is setting up a widget instance in the desired element", ->
    resetWidgetsContainer()
    setSandbox()
    setupWidgetInContainer('#sandbox')
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
    setupTwoWidgetsInContainers()
    Twitter.Controller.hideForms()
    expect($("#{container1} [data-id=twitter-form]").attr('style')).toEqual('display: none;')
    expect($("#{container2} [data-id=twitter-form]").attr('style')).toEqual('display: none;')

  it "showForms is showing the forms of all the widgets that are initialized", ->
    resetWidgetsContainer()
    setupTwoWidgetsInContainers()
    Twitter.Controller.hideForms()
    Twitter.Controller.showForms()
    expect($("#{container1} [data-id=twitter-form]").attr('style')).not.toEqual('display: none;')
    expect($("#{container2} [data-id=twitter-form]").attr('style')).not.toEqual('display: none;')

  it "closeWidgetInContainer will eliminate the widget from the given container", ->
    resetWidgetsContainer()
    setupTwoWidgetsInContainers()
    Twitter.Controller.closeWidgetInContainer(container1)
    expect($("#{container1} [data-id=twitter-form]")).not.toBeInDOM()
    expect($("#{container2} [data-id=twitter-form]")).toBeInDOM()

  it "closeWidgetInContainer will remove the widget from the widgets container", ->
    resetWidgetsContainer()
    setupTwoWidgetsInContainers()
    Twitter.Controller.closeWidgetInContainer(container1)
    expect(Twitter.Controller.getWidgets().length).toEqual(1)

  it "allWidgetsExecute is removing the inactive widgets", ->
    resetWidgetsContainer()
    setupTwoWidgetsInContainers()
    Twitter.Controller.widgets[0].setAsInactive()
    Twitter.Controller.allWidgetsExecute('hideForm')
    expect(Twitter.Controller.widgets.length).toBe(1)

