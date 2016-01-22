
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()

config = require('../config')
promisify_db = require '../../../openbeelab-db-util/javascript/promisify_dbDriver'

dbDriver = require('../../../openbeelab-db-util/javascript/mockDriver')
Promise = require 'promise'


usersDb = dbDriver.connectToServer(config.database).useDb("_users")

createUsers = require '../create_users'

describe "an admin and an uploader for a db",->

    it "should be created", (done)->

        createUsers(usersDb,dbName)
        .then (users)->
            
            usersDb.get(users.filter((user)-> user.roles.contains(dbName+"/admin"))[0]._id).then (user)->

                user.name.must.be(dbName+"_admin")
                user._id.must.be("org.couchdb.user:" + dbName+"_admin")
                user.roles.must.contain(dbName+"/admin")

            usersDb.get(users.filter((user)-> user.roles.contains(dbName+"/uploader"))[0]._id).then (user)->

                user.name.must.be(dbName+"_uploader")
                user._id.must.be("org.couchdb.user:" + dbName+"_uploader")
                user.roles.must.contain(dbName+"/uploader")

            done()
           