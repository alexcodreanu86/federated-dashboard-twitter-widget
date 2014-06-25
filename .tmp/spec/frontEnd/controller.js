(function() {
  var clickButton, getJsonObject, setInputValue, setupFixtures, setupTwitterDisplay, twitterResponse;

  setupFixtures = function() {
    return setFixtures("<input name='twitter-search'>\n<button data-id='twitter-button'></button>\n<div data-id='twitter-output'></div>");
  };

  setInputValue = function(value) {
    return $('[name=twitter-search]').val(value);
  };

  clickButton = function() {
    return $('[data-id=twitter-button]').click();
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

  setupTwitterDisplay = function() {
    setupFixtures();
    Twitter.Controller.bind();
    return setInputValue('bikes');
  };

  describe("Twitter.Controller", function() {
    it("bind displays tweets with the search input when twitter button is clicked", function() {
      var server;
      setupTwitterDisplay();
      server = sinon.fakeServer.create();
      server.respondWith(/.+/, getJsonObject());
      clickButton();
      server.respond();
      expect($('[data-id=twitter-output]')).toContainText("Some Text");
      expect($('[data-id=twitter-output]')).toContainText("Other text");
      expect($('[data-id=twitter-output]')).toContainText("Third text");
      return server.restore();
    });
    it("generateUrl returns a url with the string included in the string", function() {
      var url;
      url = Twitter.Controller.generateUrl('bikes');
      return expect(url).toEqual('/search_twitter/bikes');
    });
    return it("setupWidgetIn displays the twitterForm in the given container", function() {
      setFixtures(sandbox());
      Twitter.Controller.setupWidgetIn('#sandbox');
      return expect($('#sandbox')).toContainElement('[name=twitter-search]');
    });
  });

}).call(this);
