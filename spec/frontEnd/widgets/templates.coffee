twitterResponse = [
  {
    "text": "Some Text",
    "user_name": "One",
    "img_url": "mockImg/001.jpeg",
  },
  {
    "text": "Other Text",
    "user_name": "Two",
    "img_url": "mockImg/002.jpeg",
  },
  {
    "text": "Three Text",
    "user_name": "Three",
    "img_url": "mockImg/003.jpeg",
  }
]

setSandbox = ->
  setFixtures(sandbox())

appendToSandbox = (html) ->
  $("#sandbox").html(html)

assertSandboxContainsElement = (element) ->
  expect($('#sandbox')).toContainElement(element)

assertSandboxContainsText = (text) ->
  expect($('#sandbox')).toContainText(text)

describe "Twitter.Widgets.Templates", ->
  it "renderForm returns proper html", ->
    setSandbox()
    form = Twitter.Widgets.Templates.renderForm()
    appendToSandbox(form)
    assertSandboxContainsElement('[name=widget-input]')
    assertSandboxContainsElement('[data-name=form-button]')
    assertSandboxContainsElement('[data-name=widget-output]')

  it "renderTweets has tweets' text in the rendered html", ->
    setSandbox()
    tweetsHtml = Twitter.Widgets.Templates.renderTweets(twitterResponse)
    appendToSandbox(tweetsHtml)
    assertSandboxContainsElement('[data-id=tweet-content]')
    assertSandboxContainsText(twitterResponse[0].text)
    assertSandboxContainsText(twitterResponse[1].text)
    assertSandboxContainsText(twitterResponse[2].text)

  it "renderTweets has tweets' users profiles img in the rendered html", ->
    setSandbox()
    tweetsHtml = Twitter.Widgets.Templates.renderTweets(twitterResponse)
    appendToSandbox(tweetsHtml)
    assertSandboxContainsElement('[data-id=user-img]')
    images = $('.tweet [data-id=user-img]')
    expect($(images[0]).attr('src')).toEqual("mockImg/001.jpeg")
    expect($(images[1]).attr('src')).toEqual("mockImg/002.jpeg")
    expect($(images[2]).attr('src')).toEqual("mockImg/003.jpeg")

  it "renderTweets has tweets' users names in the rendered html", ->
    setSandbox()
    tweetsHtml = Twitter.Widgets.Templates.renderTweets(twitterResponse)
    appendToSandbox(tweetsHtml)
    assertSandboxContainsText(twitterResponse[0].user_name)
    assertSandboxContainsText(twitterResponse[1].user_name)
    assertSandboxContainsText(twitterResponse[2].user_name)

