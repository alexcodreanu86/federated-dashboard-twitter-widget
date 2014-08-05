namespace("Twitter.Widget")

class Twitter.Widgets.Display
  constructor: (container) ->
    @container = container

  setupWidget: ->
    widgetHtml = Twitter.Widgets.Templates.renderForm()
    $(@container).append(widgetHtml)

  getInput: ->
    $("#{@container} [name=twitter-search]").val()

  exitEditMode: ->
    @hideForm()
    @hideCloseWidget()

  hideForm: ->
    $("#{@container} [data-id=twitter-form]").hide()

  hideCloseWidget: ->
    $("#{@container} [data-id=twitter-close]").hide()

  enterEditMode: ->
    @showForm()
    @showCloseWidget()

  showForm: ->
    $("#{@container} [data-id=twitter-form]").show()

  showCloseWidget: ->
    $("#{@container} [data-id=twitter-close]").show()

  removeWidget: ->
    $(@container).remove()

  showTweets: (twitterResponse) ->
    formatedResponse = @formatResponse(twitterResponse)
    twitterHtml = @generateHtml(formatedResponse)
    $("#{@container} [data-id=twitter-output]").html(twitterHtml)

  formatResponse: (twitterResponse) ->
    formatedResponse = []
    _.forEach(twitterResponse, (tweet) =>
      formatedResponse.push @formatTweet(tweet)
    )
    formatedResponse

  formatTweet: (tweet) ->
    formatedTweet = {}
    formatedTweet.text = tweet.text
    formatedTweet.user_name = tweet.user.name
    formatedTweet.img_url = tweet.user.profile_image_url
    formatedTweet

  generateHtml: (twitterResponse) ->
    Twitter.Widgets.Templates.renderTweets(twitterResponse)
