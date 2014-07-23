namespace('Twitter')

class Twitter.Display
  @logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-twitter-widget/master/lib/icon_25838/icon_25838.png"

  @generateLogo: (config) ->
    logoSrc = @logoSrc
    _.extend(config, {imgSrc: logoSrc})
    Twitter.Templates.renderLogo(config)
