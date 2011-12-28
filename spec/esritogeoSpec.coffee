describe "convertEsriToGeo", ->
  util = null
  helper = null

  beforeEach ->
    require '../esritogeo'
    require '../spec_helper'
    util = new GeoUtil()
    helper = new SpecHelper()

  afterEach ->
    delete util
    delete helper

  it "should be able to strip newlines from JSON", ->
    result = util.stripJSON helper.dirty()
    expect(result).toEqual helper.clean()

  it "should convert JSON string to Object", ->
    result = util.jsonToObject helper.dirty()
    expect(result).toBeTruthy()

  it "should return a valid geometry type", ->
    type = "esriGeometryPoint"
    result = util.parseGeometryType type
    expect(result).toEqual "Point"

    type = "esriGeometryMultiPoint"
    result = util.parseGeometryType type
    expect(result).toEqual "MultiPoint"

    type = "esriGeometryPolyline"
    result = util.parseGeometryType type
    expect(result).toEqual "LineString"

    type = "esriGeometryPolygon"
    result = util.parseGeometryType type
    expect(result).toEqual "Polygon"

    type = "nothing"
    result = util.parseGeometryType type
    expect(result).toEqual "unknown"

  it "should convert a feature object to GeoJSON compatible feature", ->
    json = util.jsonToObject helper.dirty()
    type = 'Polygon'
    result = util.featureToGeo json.features[0], type
    expect(result).toBeTruthy()

  it "should convert EsriJSON to GeoJSON and call a callback function", ->
    util.convertEsriToGeo helper.dirty(), (errors, result) ->
      expect(result).toBeTruthy()
