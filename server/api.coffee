### my-data API ###
Firebase = require 'firebase'


exports.Api = class Api
  constructor: (cfg) ->
    @cfg = cfg  # Save config values

  get: (key, callback) ->  
    firebase = new Firebase @cfg.FIREBASE + key
    firebase.on 'value', (data) ->
      if data.val() is null
        callback "Parameter does not exist"
      else
        callback data.val()

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