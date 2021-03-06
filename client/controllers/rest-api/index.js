// Generated by CoffeeScript 1.6.3
/* rest-api - Controller for calling a RESTful API
      -Makes requests to an API of your choosing
      -Retrieves Endpoints from the rest-endpoint data model
      -Can get, delete, update
*/


(function() {
  var Api, Endpoint, EndpointView, reactive,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Endpoint = require('rest-endpoint');

  EndpointView = require('endpoint-view');

  reactive = require('reactive');

  module.exports = Api = (function() {
    function Api(hostname, port, prefix) {
      this.get = __bind(this.get, this);
      this.hostname = hostname || 'localhost';
      this.port = port || 3000;
      this.prefix = 'api';
      this.url = "http://" + this.hostname + ":" + this.port + "/" + this.prefix;
    }

    Api.prototype.get = function(ctx) {
      var endpoint, keyUrl, version;
      console.log(ctx);
      version = ctx.params.version;
      keyUrl = ctx.params[0];
      endpoint = new Endpoint({
        url: this.url,
        version: version,
        keyUrl: keyUrl
      });
      return endpoint.get(function(data) {
        var values;
        values = document.querySelector('.values');
        console.log(values);
        console.log(endpoint);
        return reactive(values, endpoint);
      });
    };

    return Api;

  })();

}).call(this);
