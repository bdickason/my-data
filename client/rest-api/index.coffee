Endpoint = require 'rest-endpoint'

module.exports = class Api
  constructor: ->  

  # Make a get request to the API
  get: (ctx) ->
    console.log ctx
    version = ctx.params.version
    key = ctx.params[0]
    endpoint = new Endpoint version, key
    endpoint.get (data) ->