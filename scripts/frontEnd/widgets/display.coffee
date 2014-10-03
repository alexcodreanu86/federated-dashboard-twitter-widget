namespace("Twitter.Widget")

class Twitter.Widgets.Display
  constructor: (container, animationSpeed) ->
    @container = container
    @animationSpeed = animationSpeed

  setupWidget: ->
    widgetHtml = Twitter.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=widget-input]").val()

  removeWidget: ->
    $(@container).remove()

  showTweets: (twitterResponse) ->
    formatedResponse = @formatResponse(twitterResponse)
    twitterHtml = @generateHtml(formatedResponse)
    $("#{@container} [data-name=widget-output]").html(twitterHtml)

  formatResponse: (twitterResponse) ->
    formatedResponse = []
    _.forEach twitterResponse, (tweet) =>
      formatedResponse.push @formatTweet(tweet)

    formatedResponse

  formatTweet: (tweet) ->
    formatedTweet = {}
    formatedTweet.text = tweet.text
    formatedTweet.user_name = tweet.user.name
    formatedTweet.img_url = tweet.user.profile_image_url
    formatedTweet

  generateHtml: (twitterResponse) ->
    Twitter.Widgets.Templates.renderTweets(twitterResponse)
