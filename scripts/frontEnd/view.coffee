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

  @logoSrc = "https://d30y9cdsu7xlg0.cloudfront.net/svg/397015b2-35ac-4e35-bbb6-639160056826.svg?Expires=1403714482&amp;Signature=NIKuItmkE8UN70LX6fvBMfF9rM~TOT6FtON2fgEVZO73jmtVqaMy6uekkcqCT~Kh9NU~rEH~Txaunw3RGiobW5F~i~GKokNNRD0jN5XyTxrTtShwhmi7iStGeAf2kkirZ4ZYkYi52nwHsi26N36PWwxmwPrU9-YyG8-Ud3jcZes_&amp;Key-Pair-Id=APKAI5ZVHAXN65CHVU2Q"

  @generateLogo: ->
    Twitter.Templates.renderImage(@logoSrc, "twitter-logo")
