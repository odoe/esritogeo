require './esritogeo'
require './spec_helper'

util = new GeoUtil()
helper = new SpecHelper()
util.convertEsriToGeo helper.dirty(), (errs, result)->
  console.log result
