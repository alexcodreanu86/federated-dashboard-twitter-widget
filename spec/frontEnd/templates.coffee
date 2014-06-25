setSandbox = ->
  setFixtures(sandbox())

appendToSandbox = (html) ->
  $("#sandbox").html(html)

assertSandboxContainsElement = (element) ->
  expect($('#sandbox')).toContainElement(element)

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

describe "Twitter.Templates", ->
  it "renderForm returns proper html", ->
    setSandbox()
    form = Twitter.Templates.renderForm()
    appendToSandbox(form)
    assertSandboxContainsElement('[name=twitter-search]')
    assertSandboxContainsElement('[data-id=twitter-button]')
    assertSandboxContainsElement('[data-id=twitter-output]')
