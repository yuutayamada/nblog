# Todo
# html & css minify
module.exports = (grunt) ->
  home = process.env.HOME
  article_dir = "#{home}/article"
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    uglify:
      target:
        files:
          "./heroku/public/js/bundle.min.js": ["/tmp/bundle.js"]
    shell:
      createlink:
        command: "sh ./tools/createlink.sh"
      makeArticleDir:
        command: "sh ./tools/makeArticleDir.sh"
      createHtml:
        command: ["node ./tools/convertHtmlFromMd.js",
                  "node ./tools/createJson.js"].join("&&")
      bundle:
        command: "sh ./tools/bundle.sh"
      bundle_develop:
        command: "sh ./tools/bundle.sh develop"
    coffee:
      compile:
        files:
          "./dist/libs.js": ["./dist/libs.coffee"]
    concat:
      dist:
        src: ["#{home}/.nblog","./main.coffee", "./loadfiles.coffee"]
        dest: "./build.coffee"
      develop:
        src: ["#{home}/.nblog","./main.coffee"]
        dest: "./build.coffee"
      libs:
        src: ["./templates/*.coffee", "./router.coffee"]
        dest: "./dist/libs.coffee"

  grunt.loadNpmTasks("grunt-contrib-uglify")
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-concat")
  grunt.loadNpmTasks("grunt-shell")

  # Default task(s).
  grunt.registerTask("default", [
    "concat:libs", "coffee:compile",
    "concat:dist", "shell:bundle", "uglify"
  ])
  grunt.registerTask("develop", [
    "concat:develop", "shell:bundle_develop", "uglify",
    "concat:libs", "coffee:compile", "shell:createlink"])
  grunt.registerTask("updatelibs", [
    "concat:libs", "coffee:compile", "shell:createlink"])
  grunt.registerTask("createlink", ["shell:createlink"])
  grunt.registerTask("post", [
    "shell:makeArticleDir"
    "shell:createHtml"
  ])
