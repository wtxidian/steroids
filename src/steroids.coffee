Help = require "./steroids/Help"
Weinre = require "./steroids/Weinre"


class Steroids
  @server = undefined

  constructor: ->


  parseOptions: =>

    argv = require('optimist').argv

    [firstOption, otherOptions...] = argv._

    switch firstOption
      when "create"
        ProjectCreator = require("./steroids/ProjectCreator")

        projectCreator = new ProjectCreator(otherOptions)

        projectCreator.clone(otherOptions[0])
      when "make"
        ProjectBuilder = require("./steroids/ProjectBuilder")

        projectBuilder = new ProjectBuilder(otherOptions)

        projectBuilder.ensureBuildFile()
        projectBuilder.make()

      when "debug"
        weinre = new Weinre
        weinre.run()

      when "transfer"
        @startServer()
        console.log "Waiting for client to connect, this may take a while.."

      else
        Help.usage()


  startServer: =>
    Server = require "./steroids/Server"

    @server = new Server
                    port: 4567

    @server.listen()

  install: =>
    fs = require "fs"

    banner = (fs.readFileSync("./support/banner")).toString()

    console.log banner

    console.log "installing ..."

    Installer = require "./steroids/Installer"

    installer = new Installer()
    installer.install()



module.exports =
  run: ->
    s = new Steroids
    s.parseOptions()
  install: ->
    s = new Steroids
    s.install()

  Help: Help
  paths: require "./steroids/paths"


