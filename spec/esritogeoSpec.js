
describe("convertEsriToGeo", function() {
  var helper, util;
  util = null;
  helper = null;
  beforeEach(function() {
    require('../esritogeo');
    require('../spec_helper');
    util = new GeoUtil();
    return helper = new SpecHelper();
  });
  afterEach(function() {
    delete util;
    return delete helper;
  });
  it("should be able to strip newlines from JSON", function() {
    var result;
    result = util.stripJSON(helper.dirty());
    return expect(result).toEqual(helper.clean());
  });
  it("should convert JSON string to Object", function() {
    var result;
    result = util.jsonToObject(helper.dirty());
    return expect(result).toBeTruthy();
  });
  it("should return a valid geometry type", function() {
    var result, type;
    type = "esriGeometryPoint";
    result = util.parseGeometryType(type);
    expect(result).toEqual("Point");
    type = "esriGeometryMultiPoint";
    result = util.parseGeometryType(type);
    expect(result).toEqual("MultiPoint");
    type = "esriGeometryPolyline";
    result = util.parseGeometryType(type);
    expect(result).toEqual("LineString");
    type = "esriGeometryPolygon";
    result = util.parseGeometryType(type);
    expect(result).toEqual("Polygon");
    type = "nothing";
    result = util.parseGeometryType(type);
    return expect(result).toEqual("unknown");
  });
  it("should convert a feature object to GeoJSON compatible feature", function() {
    var json, result, type;
    json = util.jsonToObject(helper.dirty());
    type = 'Polygon';
    result = util.featureToGeo(json.features[0], type);
    return expect(result).toBeTruthy();
  });
  return it("should convert EsriJSON to GeoJSON and call a callback function", function() {
    return util.convertEsriToGeo(helper.dirty(), function(errors, result) {
      return expect(result).toBeTruthy();
    });
  });
});
