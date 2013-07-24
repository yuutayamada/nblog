/*
 * GET home page.
 */

exports.index = function(req, res) {
  var develop = "";
  if (process.argv[2] && process.argv[2].match("develop"))
    develop = true;
  res.render('index', {develop: develop});
};
