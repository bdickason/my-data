// Generated by CoffeeScript 1.6.3
/* rest-endpoint - Model representing a single endpoint 
      -e.x. /email could contain :
              { personal: "dickason@gmail.com", work: "brad@shapeways.com"}
      -which would make /email/personal:
              "dickason@gmail.com"
*/


(function() {
  var Endpoint, model, request;

  request = require('superagent');

  model = require('model');

  module.exports = Endpoint = model('Endpoint').attr('url').attr('version').attr('keyUrl').attr('key').attr('value');

  Endpoint.prototype.get = function(callback) {
    var _this = this;
    return request.get("" + this.attrs.url + "/" + this.attrs.version + "/" + this.attrs.keyUrl, function(err, res) {
      if (err) {
        return console.log("Error: " + err);
      } else {
        _this.set({
          key: _this.parseUrl(_this.attrs.keyUrl)
        });
        if (typeof res.body === String) {
          _this.value = res.body;
        } else {
          _this.value = res.text;
        }
        return callback(res.body);
      }
    });
  };

  Endpoint.prototype.toString = function() {
    var output;
    output = "";
    output += "Key: " + this.attrs.key + "\n";
    output += "Version: " + this.attrs.version + "\n";
    output += "Url: " + this.attrs.url + "\n";
    return output;
  };

  Endpoint.prototype.parseUrl = function(keyUrl) {
    var parameters;
    if (keyUrl[keyUrl.length - 1] === '/') {
      keyUrl = keyUrl.slice(0, keyUrl.length - 1);
    }
    parameters = keyUrl.split('/');
    return parameters[parameters.length - 1];
  };

}).call(this);
