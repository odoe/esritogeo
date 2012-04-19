(function() {
  var helper, util;

  require('./src/esritogeo');

  require('./spec_helper');

  util = new GeoUtil();

  helper = new SpecHelper();

  util.convertEsriToGeo(helper.dirty(), function(errs, result) {
    return console.log(result);
  });

}).call(this);
