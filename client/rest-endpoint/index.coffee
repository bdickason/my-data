request = require 'superagent'

module.exports = class Endpoint
  constructor: (version, key) ->
    @version = version || 'v0'
    @key = key || '' # url to access
    @url_base = 'http://localhost:3000/api'
    

  get: (callback) ->
    console.log "Key: " + @key
    console.log "Version: " + @version

    request.get "#{@url_base}/#{@version}/#{@key}", (err, res) =>
      if err
        console.log "Error: " + err
      else
        console.log res.body
        callback res.body