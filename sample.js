var helper, util;

require('./esritogeo');

require('./spec_helper');

util = new GeoUtil();

helper = new SpecHelper();

util.convertEsriToGeo(helper.dirty(), function(errors, result) {
  return console.log(result);
});
