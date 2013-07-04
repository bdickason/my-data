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