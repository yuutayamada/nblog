# Todo
# html & css minify
module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
  coffee_files = "./config.coffee ./main.coffee"
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
          "browserify -t coffeeify ./build.coffee > /tmp/bundle.js"
        ].join("&&")
      bundle_develop:
        command: [
          "node ./tools/convertHtmlFromMd.js"
          "node ./tools/createJson.js"
          "browserify -t coffeeify #{coffee_files} > /tmp/bundle.js"
        ].join("&&")
    coffee:
      views:
        files:
          './dist/views.js': ['./templates/*.coffee']
    concat:
      dist:
        src: ["./config.coffee",'./main.coffee', './libs.coffee']
        dest: './build.coffee'
      develop:
        src: ["./config.coffee",'./main.coffee']
        dest: './build.coffee'
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-shell')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-concat')
  # Default task(s).
  grunt.registerTask("default", ["coffee:views", "concat:dist",
    "shell:bundle", "uglify"])
  grunt.registerTask("develop", ["concat:develop",
    "shell:bundle_develop", "uglify", "shell:createlink"])
