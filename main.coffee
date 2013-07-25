window._ = require("underscore")
fileInfo = require("./tools/fileInformation.json")
window.fileInfomation = _.sortBy(fileInfo, (info) ->
  return info["date"]
).reverse()

window.jQuery = window.$ = require("jquery-browserify")
window.Backbone = require("backbone-browserify")
window.Backbone.$ = $

