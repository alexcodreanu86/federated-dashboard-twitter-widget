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

  @generateLogo: ->
    logoSrc = "https://d30y9cdsu7xlg0.cloudfront.net/svg/f7bab68f-2ac2-493e-95f9-3e73356dc…I9OMEUaVZnI2ATZDqWv2Q~Wszhd5bqmIf8Us_&amp;Key-Pair-Id=APKAI5ZVHAXN65CHVU2Q"
    Twitter.Templates.renderImage(logoSrc, "twitter-logo")
