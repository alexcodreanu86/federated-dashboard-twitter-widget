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
