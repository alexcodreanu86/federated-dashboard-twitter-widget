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
      console.log(twitterResponse);
      twitterHtml = this.generateHtml(twitterResponse);
      return $('[data-id=twitter-output]').html(twitterHtml);
    };

    Display.showFormIn = function(container) {
      var formHtml;
      formHtml = Twitter.Templates.renderForm();
      return $(container).html(formHtml);
    };

    return Display;

  })();

}).call(this);
