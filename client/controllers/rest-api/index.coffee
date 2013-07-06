Endpoint = require 'rest-endpoint'
reactive = require 'reactive'

module.exports = class Api
  constructor: (hostname, port, prefix) ->  
    @hostname = hostname || 'localhost' 
    @port = port || 3000
    @prefix = 'api' # Directory prefix for api calls
    @url = "http://#{@hostname}:#{@port}/#{@prefix}"

  # Make a get request to the API
  get: (ctx) =>
    console.log ctx
    version = ctx.params.version
    key = ctx.params[0]
    console.log @url
    endpoint = new Endpoint
      url: @url, 
      version: version, 
      key: key

    endpoint.get (data) ->
      console.log data
      # Render view
      values = document.querySelector '.values' 

      reactive values, endpoint

      for key, value of data
        # Construct table row for entity
        console.log "Key: " + key
        console.log "Value: " + value
        child = "<tr id='#{key}'><td class='key'>#{key}</td><td class='value'>#{value}</td><td class='actions'>a1</td></tr>"
        console.log child
        # values.appendChild child