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
app.delete '/:version/*', api.delete
  
app.get '/:version', (req, res) ->
  # Fixes the route /v0 that doesn't fit into above framework
  res.redirect '/' + req.params.version + '/'


# Main client-side Application
app.get '/', (req, res) ->
  if req.query.format is 'json'
      res.send "Your home goes here!"
    else
      res.sendfile 'index.html'

### Start the App ###
app.listen "#{cfg.PORT}"