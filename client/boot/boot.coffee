### boot - This is the core client application ###

page = require 'page'


### Routes ###

# Homepage
page '/', (ctx) ->
  console.log 'Homepage'
  console.log ctx

# Endpoints
page '/:version/*', (ctx) ->
  console.log ctx.pathname

# Logout
page '/logout', (ctx) ->
  console.log 'Logout'

# Catchall route - If route doesn't exist
page '*', (ctx) ->
  console.log '404'

page()

