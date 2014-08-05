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

setupOneContainer = ->
  setFixtures " <div data-id='widget-container-1'></div>"

setupTwoContainers = ->
  setFixtures """
    <div data-id='widget-container-1'></div>
    <div data-id='widget-container-2'></div>
  """

newDisplay = (container) ->
  new Twitter.Widgets.Display(container)

container1 = "[data-id=widget-container-1]"
container2 = "[data-id=widget-container-2]"

describe "Twitter.Widget.Display", ->
  it "stores the container it is initialized with", ->
    display = newDisplay(container1)
    expect(display.container).toEqual(container1)

  it "setupWidget is setting up the widget in it's container", ->
    display = newDisplay(container1)
    setupOneContainer()
    display.setupWidget()
    expect(container1).toContainElement('.widget .widget-header')

  it "getInput returns the input in the field in it's own container", ->
    setupTwoContainers()
    display1 = newDisplay(container1)
    display2 = newDisplay(container2)
    display1.setupWidget()
    display2.setupWidget()
    $("#{container1} [name=twitter-search]").val("text1")
    $("#{container2} [name=twitter-search]").val("text2")
    expect(display1.getInput()).toEqual("text1")
    expect(display2.getInput()).toEqual("text2")

  it "showTweets is displaying the twitter properly in its container", ->
    setupTwoContainers()
    display = newDisplay(container1)
    display2 = newDisplay(container2)
    display.setupWidget()
    display2.setupWidget()
    display.showTweets(twitterResponse)
    expect($("#{container1} [data-id=twitter-output]")).toContainText("Some Text")
    expect($("#{container2} [data-id=twitter-output]")).not.toContainText("Some Text")

  it "displayTweets is displaying the tweets", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.showTweets(twitterResponse)
    expect($('[data-id=twitter-output]')).toContainText("Some Text")
    expect($('[data-id=twitter-output]')).toContainText("Other text")
    expect($('[data-id=twitter-output]')).toContainText("Third text")

  it "exitEditMode is hiding the form", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.exitEditMode()
    expect($("#{container1} [data-id=twitter-form]").attr('style')).toEqual('display: none;')

  it "exitEditMode is hiding the close-widget x", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.exitEditMode()
    expect($("#{container1} [data-id=twitter-close]").attr('style')).toEqual('display: none;')

  it "enterEditMode is showing the form", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.exitEditMode()
    display.enterEditMode()
    expect($("#{container1} [data-id=twitter-form]").attr('style')).not.toEqual('display: none;')

  it "enterEditMode is showing close-widget x", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.exitEditMode()
    display.enterEditMode()
    expect($("#{container1} [data-id=twitter-close]").attr('style')).not.toEqual('display: none;')

  it "removeWidget is removing the widget's content", ->
    setupOneContainer()
    display = newDisplay(container1)
    display.setupWidget()
    display.removeWidget()
    expect($(container2)).not.toContainElement("[data-id=twitter-widget-wrapper]")

  it "formatResponse is providing the proper data format", ->
    display = newDisplay(container1)
    response = display.formatResponse(twitterResponse)
    expect(response[0].user_name).toEqual("One")
    expect(response[0].img_url).toEqual("mockImg/001.jpeg")
    expect(response[0].text).toEqual("Some Text")
