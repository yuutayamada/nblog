var _ = require("underscore");
var fs = require("fs");

var write = function(path, jsData) {
  var data = JSON.stringify(jsData);
  fs.writeFile(path, data, function(error) {
    if (error) throw error;
    console.log("saved to " + path);
  });
};

var path = require("path");
var dateFormat = function(time) {
  var y = time.getFullYear(),
      M = time.getMonth() + 1,
      d = time.getDate(),
      h = time.getHours(),
      m = time.getMinutes(),
      s = time.getSeconds();
  return y + "/" + M + "/" + d + "-" + h + ":" + m + ":" + s;
};

var fileInformations = [];
var getChangedTime = function(filepaths) {
  filepaths.forEach(function(filepath) {
    console.log(filepath);
    var abspath = path.resolve(filepath),
        formattedMtime;
    fs.stat(abspath, function(err, stats) {
      if (err) throw err;
      formattedMtime = dateFormat(stats.mtime);
      var file_name = path.basename(filepath);
      fileInformations.push({name: file_name, date: formattedMtime});
      console.log(fileInformations.length);
      if (fileInformations.length == filepaths.length) {
        var fileInfo = _.sortBy(fileInformations, function(info) {
          return info["date"];
        }).reverse();
        write("./heroku/public/js/fileInformation.json", fileInfo);
      }
    });
  });
};

var glob = require("glob"),
    options = null; // options is optional

glob("**/heroku/public/articles/*.html", options, function (err, files) {
  getChangedTime((files));
});
