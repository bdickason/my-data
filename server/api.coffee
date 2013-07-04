### my-data API ###
Firebase = require 'firebase'

exports.Api = class Api
  constructor: (cfg) ->
    @cfg = cfg  # Save config values

  get: (req, res) =>
    # GET a given key
    # e.g. curl http://localhost:3000/v0/email/personal
    key = req.params[0]
    console.log req.params

    firebase = new Firebase @cfg.FIREBASE + key

    firebase.on 'value', (data) ->
      if data.val() is null
        res.send 404, "Parameter does not exist"
      else
        res.json 200, data.val()

  set: (req, res) =>
    # POST a value to a given key
    # e.g. curl -X POST -H "Content-Type: application/json" -d '{"personal": "dickason@gmail.com", "work": "brad1@shapeways.com"}' http://localhost:3000/v0/email

    # PUT Update an existing key - we treat this the same as post: 'set'
    # e.g. curl -X PUT -H "Content-Type: application/json" -d '{"personal": "dickason@gmail.com", "work": "brad1@shapeways.com"}' http://localhost:3000/v0/email

    key = req.params[0]
    value = req.body

    firebase = new Firebase @cfg.FIREBASE + key

    firebase.set value, (err) ->
      if err
        res.send 404, "Error: Data could not be saved " + err
      else
        console.log "Data saved successfully"
        res.json 200, value

  delete: (req, res) =>
    # DELETE a given key and its value.
    # e.g. curl -X DELETE http://localhost:3000/v0/email/work
    console.log req.params
    key = req.params[0]

    firebase = new Firebase @cfg.FIREBASE + key
    console.log key

    firebase.remove (err) ->
      if err
        res.send 404, "Error: Data could not be deleted " + err
      else
        console.log "Data deleted successfully"
        res.json 200, key

  parseUrl: (params) ->
    # Take URL as input (via API or www) and transform it into string that represents a JSON key
    parsedParams = params.split '/'

    return parsedParams