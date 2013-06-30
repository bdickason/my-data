express = require 'express'
cfg = require './cfg/config.js'
Api = (require './lib/api.js').Api

app = express()
app.use express.bodyParser()
app.use express.cookieParser()

### Controllers ###
api = new Api cfg

### Routes ###  

### API - Examples
app.get '/v0/name', (req, res) ->
  name =
    first: "Brad"
    last: "Dickason"

  res.send name

app.get '/v0/email', (req, res) ->
  email = 
    personal: "dickason@gmail.com",
    work: "brad@shapeways.com"

  res.send email

app.get '/v0/social', (req, res) ->
  social =
    facebook: null,
    instagram: "bdickason",
    twitter: "@bdickason",
    web: "bdickason.com"

  res.send social ###

# GET /version/endpoint - Anything under /version should be treated as a json object
app.get '/:version/*', (req, res) ->
  # GET a given key
  # e.g. curl http://localhost:3000/v0/email/personal
  console.log req.params
  api.get req.params[0], (callback) ->
    res.send callback

app.post '/:version/*', (req, res) ->
  # POST a value to a given key
  # e.g. curl -X POST -H "Content-Type: application/json" -d '{"personal": "dickason@gmail.com", "work": "brad1@shapeways.com"}' http://localhost:3000/v0/email/work
  console.log req.params
  api.set req.params[0], req.body, (callback) ->
    res.send callback

app.put '/:version/*', (req, res) ->
  # Update an existing key - we treat this the same as post: 'set'
  # e.g. curl -X PUT -H "Content-Type: application/json" -d '{"personal": "dickason@gmail.com", "work": "brad1@shapeways.com"}' http://localhost:3000/v0/email/work
  console.log req.params
  api.set req.params[0], req.body, (callback) ->
    res.send callback

app.delete '/:version/*', (req, res) ->
  # Update an existing key - we treat this the same as post: 'set'
  # e.g. curl -X DELETE http://localhost:3000/v0/email/work
  console.log req.params
  api.delete req.params[0], (callback) ->
    res.send callback

  


# Docs
app.get '/'

### Start the App ###
app.listen "#{cfg.PORT}"


