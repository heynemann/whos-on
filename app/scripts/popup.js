(function() {
  'use strict';
  var BGPage;

  BGPage = chrome.extension.getBackgroundPage();

  BGPage.userDetailsHandler.getUserData(function(user) {
    return console.log(user);
  });

}).call(this);
