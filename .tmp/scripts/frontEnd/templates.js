(function() {
  namespace('Twitter');

  Twitter.Templates = (function() {
    function Templates() {}

    Templates.renderForm = function() {
      return _.template("<div class=\"widget\" data-id=\"twitter-widget-wrapper\">\n  <div class=\"widget-header\">\n    <h2 class=\"widget-title\">Twitter</h2>\n    <div class=\"widget-form\" data-id=\"twitter-form\">\n      <input name=\"twitter-search\" type=\"text\" autofocus=\"true\">\n      <button id=\"twitter\" data-id=\"twitter-button\">Search twitter</button><br>\n    </div>\n  <div class=\"widget-body\" data-id=\"twitter-output\"></div>\n</div>");
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
