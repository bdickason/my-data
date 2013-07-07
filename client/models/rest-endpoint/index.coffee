### rest-endpoint - Model representing a single endpoint 
      -e.x. /email could contain :
              { personal: "dickason@gmail.com", work: "brad@shapeways.com"}
      -which would make /email/personal:
              "dickason@gmail.com"
###

request = require 'superagent'
model = require 'model'


module.exports = Endpoint = model('Endpoint')
  .attr('version')  # Version of the API to call (e.g. 'v0')
  .attr('key')      # Key to access this endpoint (e.g. '/email')
  .attr('value')    # Value associated with key
  .attr('url')      # Url to the data store (should always be passed in by the controller)

  # Call the data store (in this case our API) for the model info
  Endpoint.prototype.get = (callback) ->
    console.log "Key: " + @attrs.key
    console.log "Version: " + @attrs.version
    console.log "Url: " + @attrs.url

    request.get "#{@attrs.url}/#{@attrs.version}/#{@attrs.key}", (err, res) =>
      if err
        console.log "Error: " + err
      else
        callback res.body