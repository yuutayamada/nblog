# Todo
# html & css minify
module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
  home = process.env.HOME
  article_dir = "#{home}/article"
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    uglify:
      target:
        options:
          banner: banner
        files:
          "./heroku/public/js/bundle.min.js": ["/tmp/bundle.js"]
    shell:
      createlink:
        command: "sh ./tools/createlink.sh"
      makeArticleDir:
        command: ["rm -fr ./src"
                  "mkdir -p #{article_dir}",
                  "ln -s -d #{article_dir} ./src"].join("&&")
      bundle:
        command: [
          "node ./tools/convertHtmlFromMd.js"
          "mv ./src/*.md ./src/_posted/"
          "node ./tools/createJson.js"
          "browserify -t coffeeify ./build.coffee > /tmp/bundle.js"
        ].join("&&")
      bundle_develop:
        command: [
          "node ./tools/convertHtmlFromMd.js"
          "node ./tools/createJson.js"
          "browserify -t coffeeify ./build.coffee > /tmp/bundle.js"
        ].join("&&")
    coffee:
      views:
        files:
          './dist/views.js': ['./templates/*.coffee']
    concat:
      dist:
        src: ["#{home}/.nblog","./main.coffee", "./loadfiles.coffee"]
        dest: "./build.coffee"
      develop:
        src: ["#{home}/.nblog","./main.coffee"]
        dest: "./build.coffee"
  grunt.loadNpmTasks("grunt-contrib-uglify")
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-shell")
  # Default task(s).
  grunt.registerTask("default", [
    "coffee:views", "concat:dist", "shell:bundle", "uglify"
  ])
  grunt.registerTask("develop", ["concat:develop",
    "shell:bundle_develop", "uglify", "shell:createlink"])
