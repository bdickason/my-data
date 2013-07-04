// Generated by CoffeeScript 1.6.3
/* my-data API*/


(function() {
  var Api, Firebase,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Firebase = require('firebase');

  exports.Api = Api = (function() {
    function Api(cfg) {
      this.get = __bind(this.get, this);
      this.cfg = cfg;
    }

    Api.prototype.get = function(req, res) {
      var firebase, key;
      console.log(req.params);
      key = req.params[0];
      firebase = new Firebase(this.cfg.FIREBASE + key);
      return firebase.on('value', function(data) {
        if (data.val() === null) {
          return res.send(404, "Parameter does not exist");
        } else {
          return res.send(200, data.val());
        }
      });
    };

    Api.prototype.set = function(key, value, callback) {
      var firebase;
      firebase = new Firebase(this.cfg.FIREBASE + key);
      console.log(value);
      return firebase.set(value, function(err) {
        if (err) {
          return callback("Error: Data could not be saved " + err);
        } else {
          console.log("Data saved successfully");
          return callback();
        }
      });
    };

    Api.prototype["delete"] = function(key, callback) {
      var firebase;
      firebase = new Firebase(this.cfg.FIREBASE + key);
      console.log(key);
      return firebase.remove(function(err) {
        if (err) {
          return callback("Error: Data could not be deleted " + err);
        } else {
          console.log("Data deleted successfully");
          return callback();
        }
      });
    };

    Api.prototype.parseUrl = function(params) {
      var parsedParams;
      parsedParams = params.split('/');
      return parsedParams;
    };

    return Api;

  })();

}).call(this);
