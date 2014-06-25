(function() {
  namespace('Twitter');

  Twitter.Controller = (function() {
    function Controller() {}

    Controller.bind = function() {
      return $('[data-id=twitter-button]').click((function(_this) {
        return function() {
          return _this.getTweeterPosts(Twitter.Display.getInput());
        };
      })(this));
    };

    Controller.getTweeterPosts = function(searchInput) {
      var url;
      url = this.generateUrl(searchInput);
      return $.get(url, function(response) {
        return Twitter.Display.showTweets(response);
      }, 'json');
    };

    Controller.generateUrl = function(input) {
      return "/search_twitter/" + input;
    };

    Controller.setupWidgetIn = function(element) {
      Twitter.Display.showFormIn(element);
      return this.bind();
    };

    Controller.iconUrl = "https://d30y9cdsu7xlg0.cloudfront.net/svg/f7bab68f-2ac2-493e-95f9-3e73356dcf43.svg?Expires=1403711665&amp;Signature=A4Di1ydRnSwxz75IFrSbz36lWvpMCoDZv6kXwkI5PzYPKldyKXva6ej5a80n2f2AHRM6HNM9EAq5OP9CbZeqhsjSonYXfI-uTn68SDW26uv5tgMFwFhSSRdSHlmKHfH6z4XaAaoI9OMEUaVZnI2ATZDqWv2Q~Wszhd5bqmIf8Us_&amp;Key-Pair-Id=APKAI5ZVHAXN65CHVU2Q";

    return Controller;

  })();

}).call(this);
