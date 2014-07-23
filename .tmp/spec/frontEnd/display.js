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
    return it("generateLogo returns the twitter image tag", function() {
      var imageHtml;
      imageHtml = Twitter.Display.generateLogo({
        dataId: "twitter-logo"
      });
      return expect(imageHtml).toBeMatchedBy('[data-id=twitter-logo]');
    });
  });

}).call(this);
