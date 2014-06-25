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

    Display.logoSrc = "https://d30y9cdsu7xlg0.cloudfront.net/svg/397015b2-35ac-4e35-bbb6-639160056826.svg?Expires=1403714482&amp;Signature=NIKuItmkE8UN70LX6fvBMfF9rM~TOT6FtON2fgEVZO73jmtVqaMy6uekkcqCT~Kh9NU~rEH~Txaunw3RGiobW5F~i~GKokNNRD0jN5XyTxrTtShwhmi7iStGeAf2kkirZ4ZYkYi52nwHsi26N36PWwxmwPrU9-YyG8-Ud3jcZes_&amp;Key-Pair-Id=APKAI5ZVHAXN65CHVU2Q";

    Display.generateLogo = function() {
      return Twitter.Templates.renderImage(this.logoSrc, "twitter-logo");
    };

    return Display;

  })();

}).call(this);
