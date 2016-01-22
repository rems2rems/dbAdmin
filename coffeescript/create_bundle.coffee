module.exports = (config,dbServer)->
    
    insert_location = require './insert_location'
    insert_stand = require './insert_stand'
    insert_beehouse = require './insert_beehouse'
    createViews = require './create_views'
    createUsers = require './create_users'
    Promise = require "promise"

    dbName = config.database.name
    
    usersDb = dbServer.useDb("_users")
    configDb = dbServer.useDb(config.database.name + "_config")
    dataDb = dbServer.useDb(config.database.name + "_data")
    
    usersPromises = []
    for user in config.database.users

        do (user)->

            for role,i in user.roles
                user.roles[i] = dbName + "/" + role

            userPromise = usersDb.save(user)
            userPromise.then (res)->

                console.log("user " + user.name + " created.")
                return user
                    
            usersPromises.push userPromise

    Promise.all(usersPromises).then ->

        configDb.create()

    .then ()->

        secu = config.database.securityObject
        for role,i in secu.admins.roles
            secu.admins.roles[i] = dbName + "/" + role
        for role,i in secu.members.roles
            secu.members.roles[i] = dbName + "/" + role

        configDb.save secu

    .then ()->

        createViews(configDb,"config")

    .then ()->

        createUsers(usersDb,dbName)

    .then (users)->

        console.log users
        console.log "dbAdmin login:" + users.admin.name
        console.log "dbAdmin password:" + users.admin.password
        
        console.log "dbUploader login:" + users.uploader.name
        console.log "dbUploader password:" + users.uploader.password

        console.log "config db created."

    .then ()->
        
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
        dataDb.create()

    .then () ->

        createViews(dataDb,"data")

    .then () ->

        console.log "data db created."