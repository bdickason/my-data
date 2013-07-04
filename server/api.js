// Generated by CoffeeScript 1.6.3
/* my-data API*/


(function() {
  var Api, Firebase;

  Firebase = require('firebase');

  exports.Api = Api = (function() {
    function Api(cfg) {
      this.cfg = cfg;
    }

    Api.prototype.get = function(key, callback) {
      var firebase;
      firebase = new Firebase(this.cfg.FIREBASE + key);
      return firebase.on('value', function(data) {
        if (data.val() === null) {
          return callback("Parameter does not exist");
        } else {
          return callback(data.val());
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