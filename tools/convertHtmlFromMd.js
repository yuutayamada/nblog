var md = require("markdown").markdown,
    fs = require('fs');

var glob = require('glob'),
    options = null; // options is optional

var readArticles = function(file) {
  fs.readFile(file, "utf-8", function(err, data) {
    if (err) throw err;
    var filename = file.replace("src/", ""),
        htmlfile = filename.replace(/md$/, "html"),
        writefile = ("./heroku/public/articles/" + htmlfile),
        htmlContent = md.toHTML(data);
    writeArticleToHerokuDir(writefile, htmlContent);
  });
};

var writeArticleToHerokuDir = function(writefile, htmlContent) {
  fs.writeFile(writefile, htmlContent, function(error) {
    if (error) throw error;
    console.log("saved to " + writefile);
  });
};

glob("**/src/*.md", options, function (err, files) {
  if (err) throw err;
  (files).forEach(function(file) {
    readArticles(file);
  });
});
