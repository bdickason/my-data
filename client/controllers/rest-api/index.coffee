### rest-api - Controller for calling a RESTful API
      -Makes requests to an API of your choosing
      -Retrieves Endpoints from the rest-endpoint data model
      -Can get, delete, update
###

Endpoint = require 'rest-endpoint'
reactive = require 'reactive'

module.exports = class Api
  constructor: (hostname, port, prefix) ->  
    @hostname = hostname || 'localhost'   # Hostname of your server
    @port = port || 3000                  # Port of your server
    @prefix = 'api'                       # Directory prefix for api calls
    @url = "http://#{@hostname}:#{@port}/#{@prefix}" 

  # Make a get request to the API
  get: (ctx) =>
    # ctx - Expects a context from the router (page.js) - https://github.com/visionmedia/page.js#context
    console.log ctx 
    version = ctx.params.version
    key = ctx.params[0]
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