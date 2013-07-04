express = require 'express'
cfg = require './cfg/config.js'
Api = (require './server/api.js').Api

app = express()
app.use express.static __dirname + '/static'
app.use express.favicon()
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.cookieParser()
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use app.router


### Controllers ###
api = new Api cfg

### Routes ###  

# API - User-defined Endpoints

app.get '/:version/*', (req, res) ->
  # GET a given key
  # e.g. curl http://localhost:3000/v0/email/personal
  api.get req.params[0], (callback) ->
    if req.query.format is 'json'
      res.send callback
    else
      res.render 'endpoint', { params: api.parseUrl(req.params[0]), callback: callback }

app.post '/:version/*', (req, res) ->
  # POST a value to a given key
  # e.g. curl -X POST -H "Content-Type: application/json" -d '{"personal": "dickason@gmail.com", "work": "brad1@shapeways.com"}' http://localhost:3000/v0/email
  console.log req.params
  api.set req.params[0], req.body, (callback) ->
    res.send callback

app.put '/:version/*', (req, res) ->
  # Update an existing key - we treat this the same as post: 'set'
  # e.g. curl -X PUT -H "Content-Type: application/json" -d '{"personal": "dickason@gmail.com", "work": "brad1@shapeways.com"}' http://localhost:3000/v0/email
  console.log req.params
  api.set req.params[0], req.body, (callback) ->
    res.send callback

app.delete '/:version/*', (req, res) ->
  # Update an existing key - we treat this the same as post: 'set'
  # e.g. curl -X DELETE http://localhost:3000/v0/email/work
  console.log req.params
  api.delete req.params[0], (callback) ->
    res.send callback

app.get '/:version', (req, res) ->
  # Fixes the route /v0 that doesn't fit into above framework
  console.log '/' + req.params.version + '/'
  res.redirect '/' + req.params.version + '/'


# Main Application
app.get '/', (req, res) ->
  if req.query.format is 'json'
      res.send "Your home goes here!"
    else
      res.sendfile 'index.html'

### Start the App ###
app.listen "#{cfg.PORT}"