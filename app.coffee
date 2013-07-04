express = require 'express'
cfg = require './cfg/config.js'
Api = require './server/api.js'

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
api = new Api.Api cfg

### Routes ###  

# API - User-defined Endpoints

app.get '/:version/*', api.get
app.post '/:version/*', api.set
app.put '/:version/*', api.set

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