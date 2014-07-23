namespace("Twitter.Widgets")

class Twitter.Widgets.Controller
  apiKey = undefined
  constructor: (container, key) ->
    apiKey = key
    @container = container
    @display = new Twitter.Widgets.Display(container)

  initialize: ->
    @display.setupWidget()
    @bind()

  getContainer: ->
    @container

  bind: ->
    $("#{@container} [data-id=twitter-button]").click(=> @processClickedButton())

  processClickedButton: ->
    input = @display.getInput()
    @getTwitterPosts(input)

  getTwitterPosts: (searchInput) ->
    url = @generateUrl(searchInput)
    $.get(url, (response) =>
      @display.showTweets(response)
    , 'json')

  generateUrl: (input) ->
    "/search_twitter/#{input}"

  hideForm: ->
    @display.hideForm()

  showForm: ->
    @display.showForm()

  removeContent: ->
    @display.removeWidget()
