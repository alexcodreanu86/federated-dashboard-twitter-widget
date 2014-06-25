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

    Controller.iconUrl = "https://d30y9cdsu7xlg0.cloudfront.net/svg/f7bab68f-2ac2-493e-95f9-3e73356dcf43.svg?Expires=1403711665&amp;Signature=A4Di1ydRnSwxz75IFrSbz36lWvpMCoDZv6kXwkI5PzYPKldyKXva6ej5a80n2f2AHRM6HNM9EAq5OP9CbZeqhsjSonYXfI-uTn68SDW26uv5tgMFwFhSSRdSHlmKHfH6z4XaAaoI9OMEUaVZnI2ATZDqWv2Q~Wszhd5bqmIf8Us_&amp;Key-Pair-Id=APKAI5ZVHAXN65CHVU2Q";

    return Controller;

  })();

}).call(this);

(function() {
  namespace('Twitter');

  Twitter.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function() {
      return _.template("<input name=\"twitter-search\" type=\"text\"><br>\n<button id=\"twitter\" data-id=\"twitter-button\">Search twitter</button><br>\n<div data-id=\"twitter-output\"></div>");
    };

    Templates.renderTweets = function(tweets) {
      return _.template("<% for(var i = 0; i< tweets.length; i++) { %>\n<p><%= i + 1 %> <%= tweets[i][\"text\"] %></p>\n<% } %>", {
        tweets: tweets
      });
    };

    Templates.renderImage = function(imgSrc, dataId) {
      return _.template("<img src='<%= imgSrc%>' data-id='<%= dataId %>'/>", {
        imgSrc: imgSrc,
        dataId: dataId
      });
    };

    return Templates;

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

    Display.logoSrc = "https://d30y9cdsu7xlg0.cloudfront.net/svg/397015b2-35ac-4e35-bbb6-639160056826.svg?Expires=1403714482&amp;Signature=NIKuItmkE8UN70LX6fvBMfF9rM~TOT6FtON2fgEVZO73jmtVqaMy6uekkcqCT~Kh9NU~rEH~Txaunw3RGiobW5F~i~GKokNNRD0jN5XyTxrTtShwhmi7iStGeAf2kkirZ4ZYkYi52nwHsi26N36PWwxmwPrU9-YyG8-Ud3jcZes_&amp;Key-Pair-Id=APKAI5ZVHAXN65CHVU2Q";

    Display.generateLogo = function() {
      return Twitter.Templates.renderImage(this.logoSrc, "twitter-logo");
    };

    return Display;

  })();

}).call(this);
