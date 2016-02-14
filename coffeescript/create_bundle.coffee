util = require 'util'

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
    
    logs = []
    configDb.create()
    .then ->
 
        logs.push "config db created."
        dataDb.create()
    
    .then ()->

        logs.push "data db created."
        secu = config.database.securityObject
        secu = buildDbSecurityObject(secu,config.database.name)

        Promise.all([configDb.save(secu),dataDb.save(secu)])

    .then ()->
        
        logs.push "security object created, dbs are protected."
        createViews(configDb,"config")

    .then ()->

        logs.push "config db views created."
        createUsers(usersDb,dbName)

    .then (users)->
        
        logs.push "admin credentials:"
        logs.push "login:" + users.admin.name + ",password:"+users.admin.password
        logs.push "uploader credentials:"
        logs.push "login:" + users.uploader.name + ",password:"+users.uploader.password
        logs.push "users created."
        location = config.database.configObjects.location
        insert_location(configDb,location)

    .then ()->
        
        logs.push "location created."
        p1 = configDb.save(config.database.configObjects.beehouse_model)
        p2 = configDb.save(config.database.configObjects.beehouse)

        return Promise.all([p1,p2])

    .then ()->

        logs.push "beehouse created."
        stand = config.database.configObjects.stand
        configDb.save stand
        
    .then () ->

        logs.push "stand created."
        createViews(dataDb,"data")

    .then () ->

        logs.push "data db views created"
        return logs
    .catch (err)->
    
        console.log("err:" + util.inspect(err,true,5,true))
