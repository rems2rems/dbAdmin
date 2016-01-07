# Copyright 2012-2014 OpenBeeLab.
# This file is part of the OpenBeeLab project.

# The OpenBeeLab project is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# The OpenBeeLab project is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with OpenBeeLab.  If not, see <http://www.gnu.org/licenses/>.

insert_location = require './insert_location'
insert_apiary = require './insert_apiary'
insert_stand = require './insert_stand'
insert_beehouse = require './insert_beehouse'

config = require './config'

dbDriver = require('../../openbeelab-db-util/javascript/dbUtil').configuredDriver(config.database)
promisify_db = require '../../openbeelab-db-util/javascript/promisify_cradle'

dbName = config.database.name

usersDb = dbDriver.database("_users")
usersDb = promisify_db(usersDb)
configDbName = dbName + "_config"
configDb = dbDriver.database(configDbName)
configDb = promisify_db(configDb)
dataDbName = dbName + "_data"
dataDb = dbDriver.database(dataDbName)
dataDb = promisify_db(dataDb)
Promise = require "promise"

createViews = require './create_views'
createUsers = require './create_users'

configDb.create()
.then ()->

    createViews(configDb,"config")

.then ()->

    createUsers(usersDb,configDb,dbName)

.then ()->
    
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

.catch (err)->

    console.log err
