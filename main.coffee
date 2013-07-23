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
window.fileInfomation = require "./tools/fileInformation.json"
window.jQuery = window.$ = require("jquery-browserify")
window.Backbone = require("backbone-browserify")
window.Backbone.$ = $

require "./templates/views.js"
