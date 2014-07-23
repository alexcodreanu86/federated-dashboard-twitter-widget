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
