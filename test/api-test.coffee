###
    Tests for HTTP API 
    Test Framework: Mocha (http://visionmedia.github.io/mocha/)
    Assertions: Should (https://github.com/visionmedia/should.js/)
###

Api = (require '../server/api.js').Api
cfg = require '../cfg/config.js'
should = require 'should'

api = new Api cfg;  

beforeEach ->

describe 'API GET - Get a given key', ->
  before ->
    # Populate with sample data
    _request = {
      params: ['email']
      body: {"personal": "dickason@gmail.com", "work": "brad1@shapeways.com"}
    }
    api.set _request

  it 'should accept a request for no parameters (/)', (done) ->
    # Input
    _req = {
      params: ['']
    }

    _res = {
      # Expected Output
      json: (status, data) ->
        status.should.equal 200
        data.should.not.be.null
        console.log data
        data.should.be.a 'object'
        done()

      send: (status, data) ->
        # We should never hit this in this test case
        status.should.not.equal 404
        done()
    }

    api.get _req, _res

  it 'should accept a request for one parameter (email)', (done) ->
    # Input
    _req = {
      params: ['email']
    }

    _res = {
      # Expected Output
      json: (status, data) ->
        status.should.equal 200
        data.should.not.be.null
        data.should.be.a 'object'
        done()

      send: (status, data) ->
        # We should never hit this in this test case
        status.should.not.equal 404
        done()
    }

    api.get _req, _res

  it 'should accept a request for many parameters (email/personal)', (done) ->
    # Input
    _req = {
      params: ['email/personal']
    }

    _res = {
      # Expected Output
      json: (status, data) ->
        status.should.equal 200
        data.should.not.be.null
        data.should.be.a 'string' # Firebase returns a string (non-object) for a single value
        done()

      send: (status, data) ->
        # We should never hit this in this test case
        status.should.not.equal 404
        done()
    }

    api.get _req, _res



describe 'API parseUrl - Parameter Parsing', ->
  it 'should not replace any characters in a single string.', (done) ->
    # Input
    _parameters = ['name']  # Expects array of strings.

    # Expected Output
    parametersExpected = ['name']

    parameters = api.parseUrl _parameters[0]

    parameters.should.eql parametersExpected
    done()

  it 'should replace a single / in a string', (done) ->
    # Input
    _parameters = ['name/first']  # Expects array of strings.

    # Expected Output
    parametersExpected = ['name', 'first']

    parameters = api.parseUrl _parameters[0]

    parameters.should.eql parametersExpected
    done()

  it 'should replace a single / in a string', (done) ->
    # Input
    _parameters = ['name/first/initial']  # Expects array of strings.

    # Expected Output
    parametersExpected = ['name', 'first', 'initial']

    parameters = api.parseUrl _parameters[0]

    parameters.should.eql parametersExpected
    done()