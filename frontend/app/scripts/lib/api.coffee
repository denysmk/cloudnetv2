m = require 'mithril'
Auth = require 'lib/auth'

class API
  @base = 'http://localhost:9393'

  constructor: ->
    @message = m.prop('Ready...')

  get: (path, params) ->
    @request 'GET', path, params

  # same as @get() but assumes the response will have a compressed property that needs decompressing
  getCompressed: (path, params) ->
    @get(path, params).then((response) ->
      jsonString = Decompress.decompress(
        response.base64EncodedCompressedJSON,
        response.decompressedSize
      )
      JSON.parse jsonString
    ).then(null, (error) ->
      throw new Error error
    )

  post: (path, params) ->
    @request 'POST', path, params

  request: (method, path, params) ->
    options = {
      method: method,
      url: "#{@constructor.base}/#{path}",
      data: params
    }
    Auth.request(options)

module.exports = new API
