Endpoint = require 'rest-endpoint'

module.exports = class Api
  constructor: (hostname, port, prefix) ->  
    @hostname = hostname || 'localhost' 
    @port = port || 3000
    @prefix = 'api' # Directory prefix for api calls
    @url = "http://#{@hostname}:#{@port}/#{@prefix}"

  # Make a get request to the API
  get: (ctx) ->
    console.log ctx
    version = ctx.params.version
    key = ctx.params[0]
    endpoint = new Endpoint @url, version, key
    console.log endpoint
    endpoint.get (data) ->
      console.log data
      # Render view