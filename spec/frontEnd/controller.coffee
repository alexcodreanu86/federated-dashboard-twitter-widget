describe "Twitter.Controller", ->
  describe "setupWidgetIn", ->
    it "sets up a widget template in the given container", ->
      setFixtures sandbox()
      Twitter.Controller.setupWidgetIn({container: '#sandbox'})

      expect($('#sandbox')).toContainElement('[data-name=widget-wrapper]')
