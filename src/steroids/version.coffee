paths = require "./paths"
path = require "path"

class Version

  constructor: (@options = {})->
    @pathToPackageJSON = path.join paths.npm, "package.json"

  run: (opts={}) =>
    console.log @formattedVersion()

  getVersion: =>
    steroidsCli.debug "requiring #{@pathToPackageJSON}"

    packageJSON = require @pathToPackageJSON
    steroidsCli.debug "package.json#version: #{packageJSON.version}"

    return packageJSON.version

  formattedVersion: =>
    return "AppGyver Steroids² #{@getVersion()}"

module.exports = Version
