# Helper class for testing
class SpecHelper

  constructor: () ->

  clean: () ->
    '{"displayFieldName":"LOWPARCELID","fieldAliases":{"LOWPARCELID":"Lowest Parcel Identification Number"},"geometryType":"esriGeometryPolygon","spatialReference":{"wkid":4326},"fields":[{"name":"LOWPARCELID","type":"esriFieldTypeString","alias":"Lowest Parcel Identification Number","length":30}],"features":[{"attributes":{"LOWPARCELID":"1902226080"},"geometry":{"rings":[[[-83.231458627236648,42.617199350582993],[-83.231635236861806,42.617378536183793],[-83.231669512792919,42.617422957559519],[-83.231193468607543,42.617678900083554],[-83.230976370344521,42.617458631003402],[-83.231458627236648,42.617199350582993]]]}}]}'

  dirty: () ->
    '{"displayFieldName":"LOWPARCELID",
"fieldAliases":{"LOWPARCELID":"Lowest Parcel Identification Number"},
"geometryType":"esriGeometryPolygon",
"spatialReference":{"wkid":4326},
"fields":[{"name":"LOWPARCELID",
"type":"esriFieldTypeString",
"alias":"Lowest Parcel Identification Number",
"length":30}],
"features":[{"attributes":{"LOWPARCELID":"1902226080"},
"geometry":{"rings":[[[-83.231458627236648,42.617199350582993],[-83.231635236861806,42.617378536183793],[-83.231669512792919,42.617422957559519],[-83.231193468607543,42.617678900083554],[-83.230976370344521,42.617458631003402],[-83.231458627236648,42.617199350582993]]]}}]}'

root = window ? global
root.SpecHelper = SpecHelper
