### rest-endpoint - Model representing a single endpoint 
      -e.x. /email could contain :
              { personal: "dickason@gmail.com", work: "brad@shapeways.com"}
      -which would make /email/personal:
              "dickason@gmail.com"
###

request = require 'superagent'
model = require 'model'


module.exports = Endpoint = model('Endpoint')
  .attr('url')      # Url to the data store (should always be passed in by the controller)
  .attr('version')  # Version of the API to call (e.g. 'v0')
  .attr('keyUrl')      # Key to access this endpoint (e.g. '/email')
  .attr('key')
  .attr('value')    # Value associated with key
  

  # Call the data store (in this case our API) for the model info
  Endpoint.prototype.get = (callback) ->
    request.get "#{@attrs.url}/#{@attrs.version}/#{@attrs.keyUrl}", (err, res) =>
      if err
        console.log "Error: " + err
      else
        # Set key
        @set {key: @parseUrl @attrs.keyUrl }

        # Set values
        if typeof res.body is String
          # Firebase returns a string if there's only one piece of data in a response
          @value = res.body  
        else
          # Return the full object
          @value = res.text

        callback res.body

  Endpoint.prototype.toString = () ->
    output = ""
    output += "Key: " + @attrs.key + "\n"
    output += "Version: " + @attrs.version + "\n"
    output += "Url: " + @attrs.url + "\n"
    return output

  Endpoint.prototype.parseUrl = (keyUrl) ->
    if keyUrl[keyUrl.length-1] is '/'
      # If the user appends a '/' to their url, remove it
      keyUrl = keyUrl.slice 0, keyUrl.length-1

    # Split the parameters - we only need the last one      
    parameters = keyUrl.split '/'

    return parameters[parameters.length-1]