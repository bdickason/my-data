request = require 'superagent'
model = require 'model'

module.exports = class Endpoint extends model
  constructor: (url, version, key) ->
    @version = version || 'v0'
    @key = key || '' # url to access
    @url = url || 'http://localhost:3000/api'

  get: (callback) ->
    console.log "Key: " + @key
    console.log "Version: " + @version

    request.get "#{@url}/#{@version}/#{@key}", (err, res) =>
      if err
        console.log "Error: " + err
      else
        callback res.body