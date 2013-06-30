// Generated by CoffeeScript 1.6.3
(function() {
  var Api, api, app, cfg, express;

  express = require('express');

  cfg = require('./cfg/config.js');

  Api = (require('./lib/api.js')).Api;

  app = express();

  app.use(express["static"](__dirname + '/static'));

  app.use(express.bodyParser());

  app.use(express.cookieParser());

  app.set('views', __dirname + '/views');

  app.set('view engine', 'jade');

  app.use(app.router);

  /* Controllers*/


  api = new Api(cfg);

  /* Routes*/


  /* API - Examples
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
  */


  app.get('/:version/*', function(req, res) {
    console.log(req.params);
    return api.get(req.params[0], function(callback) {
      if (req.query.format === 'json') {
        return res.send(callback);
      } else {
        return res.render('endpoint', {
          callback: callback
        });
      }
    });
  });

  app.post('/:version/*', function(req, res) {
    console.log(req.params);
    return api.set(req.params[0], req.body, function(callback) {
      if (req.query.format === 'json') {
        return res.send(callback);
      } else {
        return res.render('endpoint', {
          callback: callback
        });
      }
    });
  });

  app.put('/:version/*', function(req, res) {
    console.log(req.params);
    return api.set(req.params[0], req.body, function(callback) {
      if (req.query.format === 'json') {
        return res.send(callback);
      } else {
        return res.render('endpoint', {
          callback: callback
        });
      }
    });
  });

  app["delete"]('/:version/*', function(req, res) {
    console.log(req.params);
    return api["delete"](req.params[0], function(callback) {
      if (req.query.format === 'json') {
        return res.send(callback);
      } else {
        return res.render('endpoint', {
          callback: callback
        });
      }
    });
  });

  app.get('/', function(req, res) {
    if (req.query.format === 'json') {
      return res.send("Your home goes here!");
    } else {
      return res.render('index');
    }
  });

  /* Start the App*/


  app.listen("" + cfg.PORT);

}).call(this);
