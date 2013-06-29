express = require 'express'
cfg = require './cfg/config.js'
Firebase = require 'firebase'
Api = (require './lib/api.js').Api

app = express()
app.use express.bodyParser()
app.use express.cookieParser()

### Controllers ###
firebase = new Firebase cfg.FIREBASE
api = new Api cfg

### Routes ###  

# API - Examples
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

  res.send social

# GET /version/endpoint
app.get '/:version/*', (req, res) ->
  # Anything under /version should be treated as a json object
  console.log req.params
  parameters = api.parseUrl req.params
  res.send parameters

# Docs
app.get '/'

### Start the App ###
app.listen "#{cfg.PORT}"


