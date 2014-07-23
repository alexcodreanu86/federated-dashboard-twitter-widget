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
  it "generateLogo returns the twitter image tag", ->
    imageHtml = Twitter.Display.generateLogo({dataId: "twitter-logo"})
    expect(imageHtml).toBeMatchedBy('[data-id=twitter-logo]')
