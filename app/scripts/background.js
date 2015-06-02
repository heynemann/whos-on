(function() {
  'use strict';
  var UserDetailsHandler;

  UserDetailsHandler = (function() {
    function UserDetailsHandler() {
      this.userHandler = null;
      this.name = "Unknown User";
      this.init();
    }

    UserDetailsHandler.prototype.init = function() {
      chrome.runtime.onInstalled.addListener(function(details) {
        return console.log('previousVersion', details.previousVersion);
      });
      return chrome.browserAction.setBadgeText({
        text: '1'
      });
    };

    UserDetailsHandler.prototype.getUserData = function(callback) {
      return chrome.identity.getAuthToken({
        'interactive': true
      }, function(token) {
        var url, xmlhttp;
        url = "https://www.googleapis.com/plus/v1/people/me?access_token=" + token + "&key=680811618672-mga9f8821f52ac6tndqgf60gff9iitjh.apps.googleusercontent.com";
        xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = (function(_this) {
          return function() {
            var name, state, status, user;
            status = xmlhttp.status;
            state = xmlhttp.readyState;
            if (state < 3 || (status !== 200 && status !== 304)) {
              return console.log("ERROR", xmlhttp.status, xmlhttp.readyState);
            } else {
              user = JSON.parse(xmlhttp.responseText);
              name = user.displayName;
              if (callback) {
                return callback(name);
              }
            }
          };
        })(this);
        xmlhttp.open("GET", url);
        return xmlhttp.send();
      });
    };

    return UserDetailsHandler;

  })();

  this.userDetailsHandler = new UserDetailsHandler();

}).call(this);
