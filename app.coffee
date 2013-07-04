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

app.get '/api/:version/*', api.get
app.post '/api/:version/*', api.set
app.put '/api/:version/*', api.set
app.delete '/api/:version/*', api.delete
app.get '/api/:version', (req, res) ->
  # Redirect - Fixes the route /v0 that doesn't fit into above framework
  res.redirect '/' + req.params.version + '/'


# Main client-side Application
app.get '/*', (req, res) ->
  res.sendfile 'index.html'

### Start the App ###
app.listen "#{cfg.PORT}"