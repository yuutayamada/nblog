window.userConfig =
  title:    ""
  subtitle: ""
  author:   ""
  article:
    limit: 3
  twitter:
    account:   ''
    widget_id: ''
  coderwall:
    github_account: ''

window._ = require("underscore")
fileInfo = require("./tools/fileInformation.json")
window.fileInfomation = _.sortBy(fileInfo, (info) ->
  return info["date"]
).reverse()

window.jQuery = window.$ = require("jquery-browserify")
window.Backbone = require("backbone-browserify")
window.Backbone.$ = $

develop = true

if !develop
  require "./templates/views.js"
# require "./router.js"
