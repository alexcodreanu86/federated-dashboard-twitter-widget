(function() {
  var appendToSandbox, assertSandboxContainsElement, setSandbox, twitterResponse;

  setSandbox = function() {
    return setFixtures(sandbox());
  };

  appendToSandbox = function(html) {
    return $("#sandbox").html(html);
  };

  assertSandboxContainsElement = function(element) {
    return expect($('#sandbox')).toContainElement(element);
  };

  twitterResponse = [
    {
      "text": "Some Text"
    }, {
      "text": "Other text"
    }, {
      "text": "Third text"
    }
  ];

  describe("Twitter.Templates", function() {
    return it("renderForm returns proper html", function() {
      var form;
      setSandbox();
      form = Twitter.Templates.renderForm();
      appendToSandbox(form);
      assertSandboxContainsElement('[name=twitter-search]');
      assertSandboxContainsElement('[data-id=twitter-button]');
      return assertSandboxContainsElement('[data-id=twitter-output]');
    });
  });

}).call(this);
