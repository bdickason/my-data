### my-data API ###

exports.Api = class Api
  constructor: (cfg) ->
    @cfg = cfg  # Save config values

  parseUrl: (params) ->
    # Take URL as input (via API or www) and transform it into string that represents a JSON key
    return params[0].replace /\//g, '.' # /g Replaces all occurances (global)