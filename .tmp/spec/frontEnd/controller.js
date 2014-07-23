(function() {
  var clickOn, container1, container2, getJsonObject, resetWidgetsContainer, setSandbox, setupOneContainer, setupTwitterDisplay, setupTwoContainers, twitterResponse;

  setupOneContainer = function() {
    return setFixtures(" <div data-id='widget-container-1'></div>");
  };

  setupTwoContainers = function() {
    return setFixtures("<div data-id='widget-container-1'></div>\n<div data-id='widget-container-2'></div>");
  };

  container1 = "[data-id=widget-container-1]";

  container2 = "[data-id=widget-container-2]";

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

  setupTwitterDisplay = function() {
    setupFixtures();
    Twitter.Controller.bind();
    return setInputValue('bikes');
  };

  clickOn = function(element) {
    return $(element).click();
  };

  resetWidgetsContainer = function() {
    return Twitter.Controller.widgets = [];
  };

  setSandbox = function() {
    return setFixtures(sandbox());
  };

  setupTwoContainers = function() {
    return setFixtures("<div data-id='widget-container-1'></div>\n<div data-id='widget-container-2'></div>");
  };

  container1 = "[data-id=widget-container-1]";

  container2 = "[data-id=widget-container-2]";

  describe("Twitter.Controller", function() {
    it("setupWidgetIn displays the twitterForm in the given container", function() {
      setFixtures(sandbox());
      Twitter.Controller.setupWidgetIn('#sandbox');
      return expect($('#sandbox')).toContainElement('[name=twitter-search]');
    });
    it("widgets container is empty on initialization", function() {
      var container;
      resetWidgetsContainer();
      container = Twitter.Controller.getWidgets();
      return expect(container.length).toBe(0);
    });
    it("setupWidgetIn is setting up a widget instance in the desired element", function() {
      var html;
      resetWidgetsContainer();
      setSandbox();
      Twitter.Controller.setupWidgetIn('#sandbox', "123456");
      html = $('#sandbox');
      expect(html).toContainElement('[name=twitter-search]');
      expect(html).toContainElement('[data-id=twitter-button]');
      return expect(html).toContainElement('[data-id=twitter-output]');
    });
    it("setupWidgetIn is adding the initialized widget to the widgets container", function() {
      resetWidgetsContainer();
      setSandbox();
      Twitter.Controller.setupWidgetIn('#sandbox', "123456");
      return expect(Twitter.Controller.getWidgets().length).toEqual(1);
    });
    it("hideForms is hiding the forms of all the widgets that are initialized", function() {
      resetWidgetsContainer();
      setupTwoContainers();
      Twitter.Controller.setupWidgetIn(container1, "123456");
      Twitter.Controller.setupWidgetIn(container2, "123456");
      Twitter.Controller.hideForms();
      expect($("" + container1 + " [data-id=twitter-form]").attr('style')).toEqual('display: none;');
      return expect($("" + container2 + " [data-id=twitter-form]").attr('style')).toEqual('display: none;');
    });
    it("showForms is showing the forms of all the widgets that are initialized", function() {
      resetWidgetsContainer();
      setupTwoContainers();
      Twitter.Controller.setupWidgetIn(container1, "123456");
      Twitter.Controller.setupWidgetIn(container2, "123456");
      Twitter.Controller.hideForms();
      Twitter.Controller.showForms();
      expect($("" + container1 + " [data-id=twitter-form]").attr('style')).not.toEqual('display: none;');
      return expect($("" + container2 + " [data-id=twitter-form]").attr('style')).not.toEqual('display: none;');
    });
    it("closeWidgetInContainer will eliminate the widget from the given container", function() {
      resetWidgetsContainer();
      setupTwoContainers();
      Twitter.Controller.setupWidgetIn(container1, "123456");
      Twitter.Controller.setupWidgetIn(container2, "123456");
      Twitter.Controller.closeWidgetInContainer(container1);
      expect($("" + container1 + " [data-id=twitter-form]")).not.toBeInDOM();
      return expect($("" + container2 + " [data-id=twitter-form]")).toBeInDOM();
    });
    return it("closeWidgetInContainer will remove the widget from the widgets container", function() {
      resetWidgetsContainer();
      setupTwoContainers();
      Twitter.Controller.setupWidgetIn(container1, "123456");
      Twitter.Controller.setupWidgetIn(container2, "123456");
      Twitter.Controller.closeWidgetInContainer(container1);
      return expect(Twitter.Controller.getWidgets().length).toEqual(1);
    });
  });

}).call(this);
