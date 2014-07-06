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

    return Controller;

  })();

}).call(this);
