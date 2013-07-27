window._ = require("underscore")
fileInfo = require("./heroku/public/js/fileInformation.json")
window.fileInformation = fileInfo

window.jQuery = window.$ = require("jquery-browserify")
window.Backbone = require("backbone-browserify")
window.Backbone.$ = $
