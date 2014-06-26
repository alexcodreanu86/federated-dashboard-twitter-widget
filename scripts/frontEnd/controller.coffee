namespace('Twitter')

class Twitter.Controller
  @bind: ->
    $('[data-id=twitter-button]').click( => @getTweeterPosts(Twitter.Display.getInput()))

  @getTweeterPosts: (searchInput) ->
    url = @generateUrl(searchInput) 
    $.get(url, (response) ->
      Twitter.Display.showTweets(response)
    , 'json')

  @generateUrl: (input) ->
    "/search_twitter/#{input}"

  @setupWidgetIn: (element) ->
    Twitter.Display.showFormIn(element)
    @bind()
