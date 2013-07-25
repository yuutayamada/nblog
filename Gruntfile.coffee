# Todo
# html & css minify
module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
  coffee_files = "./config.coffee ./main.coffee ./libs.coffee"
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    uglify:
      target:
        options:
          banner: banner
        files:
          "./heroku/public/js/bundle.min.js": ["/tmp/bundle.js"]
    shell:
      createlink:
        command: 'sh ./tools/createlink.sh'
      bundle:
        command: [
          "node ./tools/convertHtmlFromMd.js"
          "mv ./src/*.md ./src/_posted/"
          "node ./tools/createJson.js"
          "browserify -t coffeeify #{coffee_files} > /tmp/bundle.js"
        ].join("&&")
    coffee:
      views:
        files:
          './templates/views.js': ['./templates/*.coffee']
      build_develop:
        files:
          './dist/build-develop.js': ['./main.coffee']
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  # Default task(s).
  grunt.registerTask("default", ["coffee:views", "shell:bundle", "uglify"])
  grunt.registerTask("develop", ["coffee:build_develop", "shell:createlink"])
