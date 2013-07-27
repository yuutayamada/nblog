window._ = require("underscore")
fileInfo = require("./tools/fileInformation.json")
window.fileInformation = fileInfo

window.jQuery = window.$ = require("jquery-browserify")
window.Backbone = require("backbone-browserify")
window.Backbone.$ = $
