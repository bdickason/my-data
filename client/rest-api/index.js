// Generated by CoffeeScript 1.6.3
(function() {
  var Api, Endpoint;

  Endpoint = require('rest-endpoint');

  module.exports = Api = (function() {
    function Api(hostname, port, prefix) {
      this.hostname = hostname || 'localhost';
      this.port = port || 3000;
      this.prefix = 'api';
      this.url = "http://" + this.hostname + ":" + this.port + "/" + this.prefix;
    }

    Api.prototype.get = function(ctx) {
      var endpoint, key, version;
      console.log(ctx);
      version = ctx.params.version;
      key = ctx.params[0];
      endpoint = new Endpoint(this.url, version, key);
      console.log(endpoint);
      return endpoint.get(function(data) {
        return console.log(data);
      });
    };

    return Api;

  })();

}).call(this);
