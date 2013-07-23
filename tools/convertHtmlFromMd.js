var md = require("markdown").markdown,
    fs = require('fs');

var glob = require('glob'),
    options = null; // options is optional

glob("**/src/*.md", options, function (err, files) {
  (files).forEach(function(file) {
    fs.readFile(file, "utf-8", function(err, data) {
      if (err) throw err;
      var filename = file.replace("src/", ""),
          htmlfile = filename.replace(/md$/, "html"),
          writefile = ("./heroku/public/articles/" + htmlfile),
          htmlContent = md.toHTML(data);
      fs.writeFile(writefile, htmlContent, function(error) {
        if (error) throw error;
        console.log("saved to " + writefile);
      });
    });
  });
});
