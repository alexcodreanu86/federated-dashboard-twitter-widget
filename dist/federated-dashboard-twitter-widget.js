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
      return _.template("<img src='<%= imgData['imgSrc'] %>' data-id='<%= imgData['dataId'] %>' style='width: <%= imgData['width'] %>px'/>", {
        imgData: imgData
      });
    };

    return Templates;

  })();

}).call(this);
