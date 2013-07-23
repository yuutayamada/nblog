window.fileInfomation = require "./tools/fileInformation.json"
window._ = require("underscore")
window.jQuery = window.$ = require("jquery-browserify")
window.Backbone = require("backbone-browserify")
window.Backbone.$ = $

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

require "./templates/views.js"
