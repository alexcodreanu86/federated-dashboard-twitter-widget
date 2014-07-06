setInputValue = (value)  ->
  $("[name=twitter-search]").val(value)

twitterResponse = [
  {
    "text": "Some Text"
  },
  {
    "text": "Other text"
  },
  {
    "text": "Third text"
  }
]

describe "Twitter.Display", ->
  it "getInput returns the text in the search box", ->
    setFixtures("<input name='twitter-search'>")
    setInputValue("bikes")
    expect(Twitter.Display.getInput()).toEqual("bikes")

  it "displayTweets is displaying the tweets", ->
    setFixtures('<div data-id="twitter-output"></div>')
    Twitter.Display.showTweets(twitterResponse)
    expect($('[data-id=twitter-output]')).toContainText("Some Text")
    expect($('[data-id=twitter-output]')).toContainText("Other text")
    expect($('[data-id=twitter-output]')).toContainText("Third text")

  it "generateLogo returns the twitter image tag", ->
    imageHtml = Twitter.Display.generateLogo({dataId: "twitter-logo"})
    expect(imageHtml).toBeMatchedBy('[data-id=twitter-logo]')

  it "hideForm is hiding the form", ->
    setFixtures(sandbox())
    Twitter.Controller.setupWidgetIn('#sandbox')
    Twitter.Display.hideForm()
    expect($('[data-id=twitter-form]').attr('style')).toEqual('display: none;')

  it "showForm displays the form", ->
    setFixtures(sandbox())
    Twitter.Controller.setupWidgetIn('#sandbox')
    Twitter.Display.hideForm()
    Twitter.Display.showForm()
    expect($('[data-id=twitter-form]').attr('style')).not.toEqual('display: none;')

