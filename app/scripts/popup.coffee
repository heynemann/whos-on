'use strict';

BGPage = chrome.extension.getBackgroundPage()
BGPage.userDetailsHandler.getUserData((user) ->
    console.log(user)
)
