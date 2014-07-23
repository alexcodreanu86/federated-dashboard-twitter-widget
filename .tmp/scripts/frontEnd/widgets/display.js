(function() {
  namespace("Twitter.Widget");

  Twitter.Widgets.Display = (function() {
    function Display(container) {
      this.container = container;
    }

    Display.prototype.setupWidget = function() {
      var widgetHtml;
      widgetHtml = Twitter.Widgets.Templates.renderForm();
      return $(this.container).append(widgetHtml);
    };

    Display.prototype.getInput = function() {
      return $("" + this.container + " [name=twitter-search]").val();
    };

    Display.prototype.hideForm = function() {
      return $("" + this.container + " [data-id=twitter-form]").hide();
    };

    Display.prototype.showForm = function() {
      return $("" + this.container + " [data-id=twitter-form]").show();
    };

    Display.prototype.removeWidget = function() {
      return $("" + this.container + " [data-id=twitter-widget-wrapper]").remove();
    };

    Display.prototype.showTweets = function(twitterResponse) {
      var twitterHtml;
      twitterHtml = this.generateHtml(twitterResponse);
      return $("" + this.container + " [data-id=twitter-output]").html(twitterHtml);
    };

    Display.prototype.generateHtml = function(twitterResponse) {
      return Twitter.Widgets.Templates.renderTweets(twitterResponse);
    };

    return Display;

  })();

}).call(this);
