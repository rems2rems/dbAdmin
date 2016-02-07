util = require 'util'
bunyan = require 'bunyan'

log = bunyan.createLogger({name: 'create-bundle'})
log.info "de la merde"

module.exports = (config,dbServer)->
    
    insert_location = require './insert_location'
    insert_stand = require './insert_stand'
    insert_beehouse = require './insert_beehouse'
    createViews = require './create_views'
    createUsers = require './create_users'
    buildDbSecurityObject = require './buildDbSecurityObject'
    Promise = require "promise"

    dbName = config.database.name
    
    usersDb = dbServer.useDb("_users")
    configDb = dbServer.useDb(config.database.name + "_config")
    dataDb = dbServer.useDb(config.database.name + "_data")
    
    configDb.create()
    .then ->
 
        console.log "config db created."
        dataDb.create()
    
    .then ()->

        console.log "data db created."
        secu = config.database.securityObject
        secu = buildDbSecurityObject(secu,config.database.name)

        Promise.all([configDb.save(secu),dataDb.save(secu)])

    .then ()->
        
        console.log "security object created, dbs are protected."
        createViews(configDb,"config")

    .then ()->

        console.log "config db views created."
        createUsers(usersDb,dbName)

    .then (users)->
        
        console.log "admin credentials:"
        console.log("login:" + users.admin.name + ",password:"+users.admin.password)
        console.log "uploader credentials:"
        console.log("login:" + users.uploader.name + ",password:"+users.uploader.password)
        console.log "users created."
        location = config.database.configObjects.location
        insert_location(configDb,location)

    .then ()->
        
        console.log "location created."
        p1 = configDb.save(config.database.configObjects.beehouse_model)
        p2 = configDb.save(config.database.configObjects.beehouse)

        return Promise.all([p1,p2])

    .then ()->

        console.log "beehouse created."
        stand = config.database.configObjects.stand
        configDb.save stand
        
    .then () ->

        console.log "stand created."
        createViews(dataDb,"data")

    .then () ->

        console.log "data db views created"
    
    .catch (err)->
    
        console.log("err:" + util.inspect(err,true,5,true))
