namespace("Twitter.Widgets")

class Twitter.Widgets.API
  @getPosts: (searchInput, displayer) ->
    url = @generateUrl(searchInput)
    $.get(url, (response) =>
      displayer.showTweets(response)
    , 'json')

  @generateUrl: (input) ->
    "/search_twitter/#{input}"

