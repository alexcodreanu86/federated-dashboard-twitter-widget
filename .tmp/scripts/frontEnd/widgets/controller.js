(function() {
  namespace("Twitter.Widgets");

  Twitter.Widgets.Controller = (function() {
    var apiKey;

    apiKey = void 0;

    function Controller(container, key) {
      apiKey = key;
      this.container = container;
      this.display = new Twitter.Widgets.Display(container);
    }

    Controller.prototype.initialize = function() {
      this.display.setupWidget();
      return this.bind();
    };

    Controller.prototype.getContainer = function() {
      return this.container;
    };

    Controller.prototype.bind = function() {
      return $("" + this.container + " [data-id=twitter-button]").click((function(_this) {
        return function() {
          return _this.processClickedButton();
        };
      })(this));
    };

    Controller.prototype.processClickedButton = function() {
      var input;
      input = this.display.getInput();
      return this.getTwitterPosts(input);
    };

    Controller.prototype.getTwitterPosts = function(searchInput) {
      var url;
      url = this.generateUrl(searchInput);
      return $.get(url, (function(_this) {
        return function(response) {
          return _this.display.showTweets(response);
        };
      })(this), 'json');
    };

    Controller.prototype.generateUrl = function(input) {
      return "/search_twitter/" + input;
    };

    Controller.prototype.hideForm = function() {
      return this.display.hideForm();
    };

    Controller.prototype.showForm = function() {
      return this.display.showForm();
    };

    Controller.prototype.removeContent = function() {
      return this.display.removeWidget();
    };

    return Controller;

  })();

}).call(this);
