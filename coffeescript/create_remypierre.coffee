module.exports = (config,dbServer)->
    
    insert_location = require './insert_location'
    insert_stand = require './insert_stand'
    insert_beehouse = require './insert_beehouse'
    createViews = require './create_views'
    createUsers = require './create_users'
    Promise = require "promise"

    util = require 'util'

    dbName = config.database.name
    
    usersDb = dbServer.useDb("_users")
    
    usersPromises = []
    for user in config.database.users

        do (user)->

            for role,i in user.roles
                user.roles[i] = dbName + "/" + role

            userPromise = usersDb.save(user)
            userPromise.then (res)->

                return user
                    
            usersPromises.push userPromise

    Promise.all(usersPromises)
    .then ->

        console.log "users created."
