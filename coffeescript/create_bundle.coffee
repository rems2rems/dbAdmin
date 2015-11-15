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

# create_database = require './create_database'

create_database = require '../../openbeelab-db-util/javascript/create_database'
insert_location = require '../../openbeelab-db-util/javascript/insert_location'
insert_apiary = require '../../openbeelab-db-util/javascript/insert_apiary'
insert_stand = require '../../openbeelab-db-util/javascript/insert_stand'
insert_beehouse = require '../../openbeelab-db-util/javascript/insert_beehouse'

config = require './config'

dbDriver = require('../../openbeelab-db-util/javascript/dbUtil').configuredDriver(config.databases.local)
promisify_db = require '../../openbeelab-db-util/javascript/promisify_cradle'

dbName = config.databases.local.name

usersDb = dbDriver.database("_users")
usersDb = promisify_db(usersDb)
db = dbDriver.database(dbName)
db = promisify_db(db)
Promise = require "promise"

create_database(usersDb,db,dbName)
.then (db)->
    
    console.log "database created."
    return db

.then (db)->
    
    location = config.databases.local.location
    insert_location(db,location)

.then ([db,location])->

    console.log "location created."
    
    apiary = config.databases.local.apiary
    db.save(apiary).then ->

        return [db,apiary]
    # insert_apiary(db,location,apiaryName)

.then ([db,apiary])->

    console.log "apiary created."
    # return apiary
    
    p1 = db.save(config.databases.local.beehouse_model)
    p2 = db.save(config.databases.local.beehouse)

    return Promise.all([p1,p2]).then ([model,beehouse])-> [db,apiary,beehouse]
    # insert_beehouse(db,apiary,model,beehouseName)

.then ([db,apiary,beehouse])->

    console.log "beehouse created."
    stand = config.databases.local.stand
    db.save stand
    # insert_stand(db,stand,apiary,beehouse)
    
.then ->

    console.log "stand created."
    
.catch (err)->

    console.log err