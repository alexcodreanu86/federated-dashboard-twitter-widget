describe "Twitter.Widgets.API", ->
  it 'generateUrl is generating propper url for the given input', ->
    url = Twitter.Widgets.API.generateUrl('apples')
    expect(url).toEqual('/search_twitter/apples')
