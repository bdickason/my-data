request = require 'superagent'

module.exports = class Endpoint
  constructor: (url, version, key) ->
    @version = version || 'v0'
    @key = key || '' # url to access
    @url = url || 'http://localhost:3000/api'
    console.log @url
    

  get: (callback) ->
    console.log "Key: " + @key
    console.log "Version: " + @version

    request.get "#{@url}/#{@version}/#{@key}", (err, res) =>
      if err
        console.log "Error: " + err
      else
        console.log res.body
        callback res.body