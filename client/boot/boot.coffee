### boot - This is the core client application ###

page = require 'page'
Api = require 'rest-api'

api = new Api
console.log api

### Routes ###

# Homepage
page '/', (ctx) ->
  console.log 'Homepage'
  console.log ctx

# Endpoints
page '/:version/*', api.get

# Logout
page '/logout', (ctx) ->
  console.log 'Logout'

# Catchall route - If route doesn't exist
page '*', (ctx) ->
  console.log '404'

page()

