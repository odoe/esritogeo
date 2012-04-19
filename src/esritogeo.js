(function() {
  var GeoUtil, root;

  GeoUtil = (function() {

    function GeoUtil() {}

    GeoUtil.prototype.stripJSON = function(str) {
      return str.replace(/\\n/g, "\\n").replace(/\\t/g, "\\t");
    };

    GeoUtil.prototype.jsonToObject = function(strIn) {
      try {
        return JSON.parse(this.stripJSON(strIn));
      } catch (err) {
        console.log(err);
        return null;
      }
    };

    GeoUtil.prototype.parseGeometryType = function(type) {
      switch (type) {
        case 'esriGeometryPoint':
          return 'Point';
        case 'esriGeometryMultiPoint':
          return 'MultiPoint';
        case 'esriGeometryPolyline':
          return 'LineString';
        case 'esriGeometryPolygon':
          return 'Polygon';
        default:
          return 'unknown';
      }
    };

    GeoUtil.prototype.featureToGeo = function(feature, type) {
      var feature_res, geometry;
      geometry = {
        type: type,
        coordinates: (function() {
          switch (type) {
            case 'Polygon':
              return feature.geometry.rings;
            case 'LineString':
              return feature.geometry.paths;
            case 'Point':
              return [feature.geometry.x, feature.geometry.y];
            default:
              return [];
          }
        })()
      };
      return feature_res = {
        type: "Feature",
        geometry: geometry,
        properties: feature.attributes
      };
    };

    GeoUtil.prototype.convertEsriToGeo = function(input, callback) {
      var errors, feature, features, json, result, type, _i, _len, _ref;
      result = null;
      errors = null;
      if (typeof input === "string") {
        json = this.jsonToObject(input);
      } else {
        json = input;
      }
      if (json !== null) {
        type = this.parseGeometryType(json.geometryType);
        features = [];
        _ref = json.features;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          feature = _ref[_i];
          features.push(this.featureToGeo(feature, type));
        }
        result = {
          type: 'FeatureCollection',
          features: features
        };
      } else {
        errors = 'Error: JSON cannot be parsed';
      }
      return callback(errors, result);
    };

    return GeoUtil;

  })();

  root = typeof window !== "undefined" && window !== null ? window : global;

  root.GeoUtil = GeoUtil;

}).call(this);
