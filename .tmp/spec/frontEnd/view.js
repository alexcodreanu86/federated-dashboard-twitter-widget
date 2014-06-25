(function() {
  var setInputValue, twitterResponse;

  setInputValue = function(value) {
    return $("[name=twitter-search]").val(value);
  };

  twitterResponse = [
    {
      "text": "Some Text"
    }, {
      "text": "Other text"
    }, {
      "text": "Third text"
    }
  ];

  describe("Twitter.Display", function() {
    it("getInput returns the text in the search box", function() {
      setFixtures("<input name='twitter-search'>");
      setInputValue("bikes");
      return expect(Twitter.Display.getInput()).toEqual("bikes");
    });
    it("displayTweets is displaying the tweets", function() {
      setFixtures('<div data-id="twitter-output"></div>');
      Twitter.Display.showTweets(twitterResponse);
      expect($('[data-id=twitter-output]')).toContainText("Some Text");
      expect($('[data-id=twitter-output]')).toContainText("Other text");
      return expect($('[data-id=twitter-output]')).toContainText("Third text");
    });
    return it("generateLogo returns the twitter image tag", function() {
      var imageHtml;
      imageHtml = Twitter.Display.generateLogo({
        dataId: "twitter-logo"
      });
      return expect(imageHtml).toBeMatchedBy('[data-id=twitter-logo]');
    });
  });

}).call(this);
