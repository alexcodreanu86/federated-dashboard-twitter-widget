namespace('Twitter')

class Twitter.Display
  @generateLogo: (config) ->
    "<i class=\"fa fa-twitter\ #{config.class}\" data-id=\"#{config.dataId}\"></i>"
