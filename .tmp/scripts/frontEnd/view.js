(function() {
  namespace('Twitter');

  Twitter.Display = (function() {
    function Display() {}

    Display.getInput = function() {
      return $('[name=twitter-search]').val();
    };

    Display.generateHtml = function(twitterResponse) {
      return Twitter.Templates.renderTweets(twitterResponse);
    };

    Display.showTweets = function(twitterResponse) {
      var twitterHtml;
      twitterHtml = this.generateHtml(twitterResponse);
      return $('[data-id=twitter-output]').html(twitterHtml);
    };

    Display.showFormIn = function(container) {
      var formHtml;
      formHtml = Twitter.Templates.renderForm();
      return $(container).html(formHtml);
    };

    Display.generateLogo = function() {
      var logoSrc;
      logoSrc = "https://d30y9cdsu7xlg0.cloudfront.net/svg/f7bab68f-2ac2-493e-95f9-3e73356dc…I9OMEUaVZnI2ATZDqWv2Q~Wszhd5bqmIf8Us_&amp;Key-Pair-Id=APKAI5ZVHAXN65CHVU2Q";
      return Twitter.Templates.renderImage(logoSrc, "twitter-logo");
    };

    return Display;

  })();

}).call(this);
