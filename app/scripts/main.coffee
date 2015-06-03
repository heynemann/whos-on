class WhosOn
    constructor: (@self, @options) ->
        @interval = null
        @initTimeout = null
        @initialize()

    initialize: ->
        @ws = new WebSocket("ws://localhost:3128/subscribe/" + window.location)

        @ws.onopen = (event) =>
            @interval = window.setInterval(=>
                @ws.send(JSON.stringify({
                    user: @self,
                    url: window.location.href
                }))
            , 1000)

        @ws.onclose = (event) =>
            @destroy()
            @initTimeout = window.setTimeout(=>
                window.clearTimeout(@initTimeout)
                @initTimeout = null
                @initialize()
            , 1000)

        @ws.onmessage = (message) =>
            console.log(message)

    destroy: ->
        window.clearInterval(@interval) if @interval
        @interval = null
        @ws.close()

window.WhosOn = WhosOn
