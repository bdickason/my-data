// Generated by CoffeeScript 1.6.3
(function() {
  var Firebase, app, cfg, express, firebase;

  express = require('express');

  cfg = require('./cfg/config.js');

  Firebase = require('firebase');

  app = express();

  app.use(express.bodyParser());

  app.use(express.cookieParser());

  /* Controllers*/


  firebase = new Firebase(cfg.FIREBASE);

  /* Routes*/


  app.get('/', function(req, res) {});

  /* Start the App*/


  app.listen("" + cfg.PORT);

}).call(this);
