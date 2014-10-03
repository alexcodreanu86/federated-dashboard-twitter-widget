namespace('Twitter')

class Twitter.Controller
  @setupWidgetIn: (settings) ->
    new Twitter.Widgets.Controller(settings).initialize()
