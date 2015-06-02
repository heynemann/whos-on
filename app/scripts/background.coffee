'use strict';

class UserDetailsHandler
    constructor: ->
        @userHandler = null
        @name = "Unknown User"
        @init()

    init: ->
        chrome.runtime.onInstalled.addListener((details) ->
            console.log('previousVersion', details.previousVersion)
        )

        chrome.browserAction.setBadgeText({text: '1'})

    getUserData: (callback) ->
        chrome.identity.getAuthToken({'interactive': true}, (token) ->
            url = "https://www.googleapis.com/plus/v1/people/me?access_token=" + token + "&key=680811618672-mga9f8821f52ac6tndqgf60gff9iitjh.apps.googleusercontent.com"
            xmlhttp = new XMLHttpRequest()
            xmlhttp.onreadystatechange = =>
              status = xmlhttp.status
              state = xmlhttp.readyState
              if state < 3 or (status != 200 and status != 304)
                console.log("ERROR", xmlhttp.status, xmlhttp.readyState)
              else
                user = JSON.parse(xmlhttp.responseText)
                name = user.displayName
                callback(name) if callback

            xmlhttp.open("GET", url);
            xmlhttp.send();
        )

@userDetailsHandler = new UserDetailsHandler()
