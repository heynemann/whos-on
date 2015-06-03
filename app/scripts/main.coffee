class WhosOn
    constructor: (@self, @options) ->
        @interval = null
        @initTimeout = null
        @initialize()

    ping: =>
        @ws.send(JSON.stringify({
            user: @self,
            url: window.location.href
        }))

        window.clearTimeout(@interval) if @interval
        @interval = window.setTimeout(@ping, 1000)

    setName: (name) ->
        @self = name

    initialize: ->
        @ws = new WebSocket("ws://localhost:3128/subscribe/" + window.location)

        @ws.onopen = (event) =>
            @ping()

        @ws.onclose = (event) =>
            @destroy()
            @initTimeout = window.setTimeout(=>
                window.clearTimeout(@initTimeout)
                @initTimeout = null
                @initialize()
            , 1000)

        @ws.onmessage = (message) =>
            console.log(message)


window.WhosOn = WhosOn
