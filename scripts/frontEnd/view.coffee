namespace('Twitter')

class Twitter.Display
  @getInput: ->
    $('[name=twitter-search]').val()

  @generateHtml: (twitterResponse) ->
    Twitter.Templates.renderTweets(twitterResponse)

  @showTweets: (twitterResponse) ->
    twitterHtml = @generateHtml(twitterResponse)
    $('[data-id=twitter-output]').html(twitterHtml)

  @showFormIn: (container) ->
    formHtml = Twitter.Templates.renderForm()
    $(container).html(formHtml)
