class GeoUtil
  constructor: () ->

  stripJSON: (str) ->
    str.replace(/\\n/g, "\\n").replace /\\t/g, "\\t"

  jsonToObject: (strIn) ->
    try
      JSON.parse @stripJSON strIn
    catch err
      console.log err
      null

  parseGeometryType: (type) ->
    switch type
      when 'esriGeometryPoint' then 'Point'
      when 'esriGeometryMultiPoint' then 'MultiPoint'
      when 'esriGeometryPolyline' then 'LineString'
      when 'esriGeometryPolygon' then 'Polygon'
      else 'unknown'

  featureToGeo: (feature, type) ->
    geometry =
      type: type
      coordinates:
        switch type
          when 'Polygon' then feature.geometry.rings
          when 'LineString' then feature.geometry.paths
          when 'Point' then [feature.geometry.x, feature.geometry.y]
          else []
    feature_res =
      type: "Feature"
      geometry: geometry
      properties: feature.attributes

  convertEsriToGeo: (string, callback) ->
    result = null
    errors = null
    json = @jsonToObject string
    if json isnt null
      type = @parseGeometryType json.geometryType
      features = []
      for feature in json.features
        features.push @featureToGeo feature, type
      result =
        type: 'FeatureCollection'
        features: features
    else
      errors = 'Error: JSON cannot be parsed'

    callback errors, result

root = window ? global
root.GeoUtil = GeoUtil
