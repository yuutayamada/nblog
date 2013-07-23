# Todo
# html & css minify
module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    uglify:
      target:
        options:
          banner: banner
        files:
          "./heroku/public/js/bundle.min.js": ["/tmp/bundle.js"]
    shell:
      bundle:
        command: [
          "node ./tools/convertHtmlFromMd.js"
          "mkdir -p ./src/_posted"
          "mv ./src/*.md ./src/_posted/"
          "node ./tools/createJson.js"
          "browserify -d -t coffeeify ./main.coffee > /tmp/bundle.js"
        ].join("&&")
    coffee:
      compile:
        files:
          './templates/views.js': ['./templates/*.coffee']
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  # Default task(s).
  grunt.registerTask("default", ["coffee", "shell", "uglify"])
