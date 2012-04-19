class GeoUtil

  constructor: () ->
  
  # Clean up new lines and single tabs from JSON string
  stripJSON: (str) ->
    str.replace(/\\n/g, "\\n").replace /\\t/g, "\\t"
  
  # Small helper to parse JSON and catch errors
  jsonToObject: (strIn) ->
    try
      JSON.parse @stripJSON strIn
    catch err
      console.log err
      null
  
  # Determine the GeoJSON geometry type
  parseGeometryType: (type) ->
    switch type
      when 'esriGeometryPoint' then 'Point'
      when 'esriGeometryMultiPoint' then 'MultiPoint'
      when 'esriGeometryPolyline' then 'LineString'
      when 'esriGeometryPolygon' then 'Polygon'
      else 'unknown'

  # Parse out geometry features for GeoJSON
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
  
  # Main method to convert ESRI JSON to GeoJSON
  convertEsriToGeo: (input, callback) ->
    result = null
    errors = null

    if typeof input is "string" then json = @jsonToObject input
    else json = input

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
