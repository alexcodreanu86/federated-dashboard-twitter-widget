(function() {
  var clickButton, container, getJsonObject, newController, setInputValue, setupOneContainer, twitterResponse;

  setInputValue = function(value) {
    return $('[name=twitter-search]').val(value);
  };

  clickButton = function(container) {
    return $("" + container + " [data-id=twitter-button]").click();
  };

  twitterResponse = [
    {
      text: "Some Text"
    }, {
      text: "Other text"
    }, {
      text: "Third text"
    }
  ];

  getJsonObject = function() {
    return JSON.stringify(twitterResponse);
  };

  setupOneContainer = function() {
    return setFixtures("<div data-id='widget-container-1'></div>");
  };

  container = "[data-id=widget-container-1]";

  newController = function(container) {
    return new Twitter.Widgets.Controller(container, "1243");
  };

  describe("Twitter.Widgets.Controller", function() {
    it("stores the container that it is initialized with", function() {
      var controller;
      controller = newController(container);
      return expect(controller.getContainer()).toEqual(container);
    });
    it("stores a new instance of Twitter.Widget.Display when instantiated", function() {
      var controller;
      controller = newController(container);
      return expect(controller.display).toBeDefined();
    });
    it("initialize sets widget up in its container", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      return expect($(container)).not.toBeEmpty();
    });
    it("initialize is binding the controller", function() {
      var controller, spy;
      controller = newController(container);
      spy = spyOn(controller, 'bind');
      controller.initialize();
      return expect(spy).toHaveBeenCalled();
    });
    it("bind displays tweets with the search input when twitter button is clicked", function() {
      var controller, server, twitterOutput;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      server = sinon.fakeServer.create();
      server.respondWith(/.+/, getJsonObject());
      clickButton(container);
      server.respond();
      twitterOutput = $("" + container + " [data-id=twitter-output]");
      expect(twitterOutput).toContainText("Some Text");
      expect(twitterOutput).toContainText("Other text");
      expect(twitterOutput).toContainText("Third text");
      return server.restore();
    });
    it("hideForm is hiding the form", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      controller.hideForm();
      return expect($("" + container + " [data-id=twitter-form]").attr('style')).toEqual('display: none;');
    });
    it("showForm is showing the form", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      controller.hideForm();
      controller.showForm();
      return expect($("" + container + " [data-id=twitter-form]").attr('style')).not.toEqual('display: none;');
    });
    return it("removeContent is removing the widget's content", function() {
      var controller;
      setupOneContainer();
      controller = newController(container);
      controller.initialize();
      controller.removeContent();
      return expect($(container)).not.toContainElement("[data-id=twitter-widget-wrapper]");
    });
  });

}).call(this);
