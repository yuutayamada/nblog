# this software is work in progress
## Sample

[example](http://howdyblog.herokuapp.com/)

## Requirement
browserify

    (sudo) npm install -g browserify

grunt

    (sudo) npm install -g grunt
## Configuration
To use this app, you should put below configuration to ./config.coffee

    window.userConfig =
      title:    ""
      subtitle: ""
      author:   ""
      # below settings are optional
      twitter:
        account:   ''
        widget_id: ''
      coderwall:
        github_account: ''
