/*
 * GET home page.
 */

var placeUrls = JSON.parse(require('fs')
                           .readFileSync('./public/js/fileInformation.json'));
var file_place = JSON.stringify(placeUrls);

exports.index = function(req, res) {
  var develop = "";
  if (process.argv[2] && process.argv[2].match("develop"))
    develop = true;
  res.render('index', {
    develop: develop,
    file_urls: file_place
  });
};
