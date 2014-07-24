(function(underscore) {
  'use strict';

  window.namespace = function(string, obj) {
    var current = window,
        names = string.split('.'),
        name;

    while((name = names.shift())) {
      current[name] = current[name] || {};
      current = current[name];
    }

    underscore.extend(current, obj);

  };

}(window._));

(function() {
  namespace('Twitter');

  Twitter.Controller = (function() {
    function Controller() {}

    Controller.widgets = [];

    Controller.setupWidgetIn = function(container, apiKey, defaultValue) {
      var widget;
      widget = new Twitter.Widgets.Controller(container, apiKey, defaultValue);
      widget.initialize();
      return this.addToWidgetsContainer(widget);
    };

    Controller.addToWidgetsContainer = function(widget) {
      return this.widgets.push(widget);
    };

    Controller.getWidgets = function() {
      return this.widgets;
    };

    Controller.hideForms = function() {
      return this.allWidgetsExecute("hideForm");
    };

    Controller.showForms = function() {
      return this.allWidgetsExecute("showForm");
    };

    Controller.allWidgetsExecute = function(command) {
      return _.each(this.widgets, (function(_this) {
        return function(widget) {
          if (widget.isActive()) {
            return widget[command]();
          } else {
            return _this.removeFromWidgetsContainer(widget);
          }
        };
      })(this));
    };

    Controller.closeWidgetInContainer = function(container) {
      var widget;
      widget = _.filter(this.widgets, function(widget, index) {
        return widget.container === container;
      })[0];
      if (widget) {
        this.removeWidgetContent(widget);
        return this.removeFromWidgetsContainer(widget);
      }
    };

    Controller.removeFromWidgetsContainer = function(widgetToRemove) {
      return this.widgets = _.reject(this.widgets, function(widget) {
        return widget === widgetToRemove;
      });
    };

    Controller.removeWidgetContent = function(widget) {
      return widget.removeContent();
    };

    return Controller;

  })();

}).call(this);

(function() {
  namespace('Twitter');

  Twitter.Display = (function() {
    function Display() {}

    Display.logoSrc = "https://raw.githubusercontent.com/bwvoss/federated-dashboard-twitter-widget/master/lib/icon_25838/icon_25838.png";

    Display.generateLogo = function(config) {
      var logoSrc;
      logoSrc = this.logoSrc;
      _.extend(config, {
        imgSrc: logoSrc
      });
      return Twitter.Templates.renderLogo(config);
    };

    return Display;

  })();

}).call(this);

(function() {
  namespace('Twitter');

  Twitter.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function() {
      return _.template("<div class=\"widget\" data-id=\"twitter-widget-wrapper\">\n  <div class=\"widget-header\">\n    <h2 class=\"widget-title\">Twitter</h2>\n    <div class=\"widget-form\" data-id=\"twitter-form\">\n      <input name=\"twitter-search\" type=\"text\" autofocus=\"true\">\n      <button id=\"twitter\" data-id=\"twitter-button\">Search twitter</button><br>\n    </div>\n  </div>\n  <div class=\"widget-body\" data-id=\"twitter-output\"></div>\n</div>");
    };

    Templates.renderTweets = function(tweets) {
      return _.template("<% for(var i = 0; i< tweets.length; i++) { %>\n<p><%= i + 1 %> <%= tweets[i][\"text\"] %></p>\n<% } %>", {
        tweets: tweets
      });
    };

    Templates.renderImage = function(imgData) {
      return _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {
        imgData: imgData
      });
    };

    Templates.renderLogo = function(imgData) {
      return this.renderImage(imgData);
    };

    return Templates;

  })();

}).call(this);

(function() {
  namespace("Twitter.Widgets");

  Twitter.Widgets.API = (function() {
    function API() {}

    API.getPosts = function(searchInput, displayer) {
      var url;
      url = this.generateUrl(searchInput);
      return $.get(url, (function(_this) {
        return function(response) {
          return displayer.showTweets(response);
        };
      })(this), 'json');
    };

    API.generateUrl = function(input) {
      return "/search_twitter/" + input;
    };

    return API;

  })();

}).call(this);

(function() {
  namespace("Twitter.Widgets");

  Twitter.Widgets.Controller = (function() {
    var apiKey;

    apiKey = void 0;

    function Controller(container, key, defaultValue) {
      apiKey = key;
      this.container = container;
      this.display = new Twitter.Widgets.Display(container);
      this.defaultValue = defaultValue;
      this.setAsInactive();
    }

    Controller.prototype.initialize = function() {
      this.display.setupWidget();
      this.bind();
      this.displayDefault();
      return this.setAsActive();
    };

    Controller.prototype.displayDefault = function() {
      if (this.defaultValue) {
        return this.getTwitterPosts(this.defaultValue);
      }
    };

    Controller.prototype.setAsActive = function() {
      return this.activeStatus = true;
    };

    Controller.prototype.setAsInactive = function() {
      return this.activeStatus = false;
    };

    Controller.prototype.isActive = function() {
      return this.activeStatus;
    };

    Controller.prototype.getContainer = function() {
      return this.container;
    };

    Controller.prototype.bind = function() {
      $("" + this.container + " [data-id=twitter-button]").click((function(_this) {
        return function() {
          return _this.processClickedButton();
        };
      })(this));
      return $("" + this.container + " [data-id=twitter-close]").click((function(_this) {
        return function() {
          return _this.closeWidget();
        };
      })(this));
    };

    Controller.prototype.processClickedButton = function() {
      var input;
      input = this.display.getInput();
      return this.getTwitterPosts(input);
    };

    Controller.prototype.getTwitterPosts = function(input) {
      return Twitter.Widgets.API.getPosts(input, this.display);
    };

    Controller.prototype.closeWidget = function() {
      this.unbind();
      this.removeContent();
      return this.setAsInactive();
    };

    Controller.prototype.removeContent = function() {
      return this.display.removeWidget();
    };

    Controller.prototype.unbind = function() {
      $("" + this.container + " [data-id=stock-button]").unbind('click');
      return $("" + this.container + " [data-id=stock-close]").unbind('click');
    };

    Controller.prototype.hideForm = function() {
      return this.display.hideForm();
    };

    Controller.prototype.showForm = function() {
      return this.display.showForm();
    };

    return Controller;

  })();

}).call(this);

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
      return $(this.container).remove();
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

(function() {
  namespace('Twitter.Widgets');

  Twitter.Widgets.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function() {
      return _.template("<div class=\"widget\" data-id=\"twitter-widget-wrapper\">\n  <div class=\"widget-header\">\n    <h2 class=\"widget-title\">Twitter</h2>\n    <span class='widget-close' data-id='twitter-close'>×</span>\n    <div class=\"widget-form\" data-id=\"twitter-form\">\n      <input name=\"twitter-search\" type=\"text\" autofocus=\"true\">\n      <button id=\"twitter\" data-id=\"twitter-button\">Search twitter</button><br>\n    </div>\n  </div>\n  <div class=\"widget-body\" data-id=\"twitter-output\"></div>\n</div>");
    };

    Templates.renderTweets = function(tweets) {
      return _.template("<% for(var i = 0; i< tweets.length; i++) { %>\n<p><%= i + 1 %> <%= tweets[i][\"text\"] %></p>\n<% } %>", {
        tweets: tweets
      });
    };

    Templates.renderImage = function(imgData) {
      return _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {
        imgData: imgData
      });
    };

    Templates.renderLogo = function(imgData) {
      return _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {
        imgData: imgData
      });
    };

    return Templates;

  })();

}).call(this);
