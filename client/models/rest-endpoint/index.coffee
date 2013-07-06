request = require 'superagent'
model = require 'model'


module.exports = Endpoint = model('Endpoint')
  .attr('version')
  .attr('key')
  .attr('url')

  Endpoint.prototype.get = (callback) ->
    console.log "Key: " + @attrs.key
    console.log "Version: " + @attrs.version
    console.log "Url: " + @attrs.url

    request.get "#{@attrs.url}/#{@attrs.version}/#{@attrs.key}", (err, res) =>
      if err
        console.log "Error: " + err
      else
        callback res.body