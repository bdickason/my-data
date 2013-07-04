### my-data API ###
Firebase = require 'firebase'

exports.Api = class Api
  constructor: (cfg) ->
    @cfg = cfg  # Save config values

  get: (req, res) =>
    # GET a given key
    # e.g. curl http://localhost:3000/v0/email/personal
    console.log req.params
    key = req.params[0]

    firebase = new Firebase @cfg.FIREBASE + key

    firebase.on 'value', (data) ->
      if data.val() is null
        res.send 404, "Parameter does not exist"
      else
        res.send 200, data.val()

  set: (key, value, callback) ->
    firebase = new Firebase @cfg.FIREBASE + key
    console.log value

    firebase.set value, (err) ->
      if err
        callback "Error: Data could not be saved " + err
      else
        console.log "Data saved successfully"
        callback()

  delete: (key, callback) ->
    firebase = new Firebase @cfg.FIREBASE + key
    console.log key

    firebase.remove (err) ->
      if err
        callback "Error: Data could not be deleted " + err
      else
        console.log "Data deleted successfully"
        callback()

  parseUrl: (params) ->
    # Take URL as input (via API or www) and transform it into string that represents a JSON key
    parsedParams = params.split '/'

    return parsedParams