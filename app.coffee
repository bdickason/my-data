express = require 'express'
cfg = require './cfg/config.js'
Firebase = require 'firebase'

app = express()
app.use express.bodyParser()
app.use express.cookieParser()

### Controllers ###
firebase = new Firebase cfg.FIREBASE

### Routes ###      
app.get '/', (req, res) ->
  
### Start the App ###
app.listen "#{cfg.PORT}"
