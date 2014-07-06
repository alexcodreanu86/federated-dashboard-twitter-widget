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

    Display.logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-twitter-widget/master/lib/icon_25838/icon_25838.png";

    Display.generateLogo = function(config) {
      var logoSrc;
      logoSrc = this.logoSrc;
      _.extend(config, {
        imgSrc: logoSrc
      });
      return Twitter.Templates.renderLogo(config);
    };

    Display.hideForm = function() {
      return $('[data-id=twitter-form]').hide();
    };

    Display.showForm = function() {
      return $('[data-id=twitter-form]').show();
    };

    return Display;

  })();

}).call(this);
