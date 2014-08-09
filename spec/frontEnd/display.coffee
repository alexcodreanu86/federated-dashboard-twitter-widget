describe "Twitter.Display", ->
  it "generateLogo returns the twitter image tag", ->
    imageHtml = Twitter.Display.generateLogo({dataId: "twitter-logo", class: "some-class"})
    expect(imageHtml).toBeMatchedBy('[data-id=twitter-logo]')
    expect(imageHtml).toBeMatchedBy('.some-class')
