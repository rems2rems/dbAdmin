
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()

config = require('../config').clone()
# console.log config.database.name

createBundle = require '../create_bundle'
# fixtures = require './testFixtures'
promisify_db = require '../../../openbeelab-db-util/javascript/promisify_dbDriver'

dbDriver = require('../../../openbeelab-db-util/javascript/mockDriver')
dbServer = dbDriver.connectToServer(config.database)
Promise = require 'promise'

describe "create a bundled db",->

    it "should work", (done)->

        # console.log config.database.name
        createBundle(config,dbServer)
        .then ->
            
            configDb = dbDriver.connectToServer(dbConfig.database).useDb(config.database.name + "_config")
            dataDb = dbDriver.connectToServer(dbConfig.database).useDb(config.database.name + "_data")
            usersDb = dbDriver.connectToServer(dbConfig.database).useDb("_users")
            
            configDb.exists().must.eventually.be.true()
            
            dataDb.exists().must.eventually.be.true()

            console.log "ici c bon"
            usersDb.get("org.couchdb.user:remy").then (user)->

                user.name.must.be("remy")

            usersDb.get("org.couchdb.user:pierre").then (user)->

                user.name.must.be("pierre")

            done()

        .catch (err)->
            # console.log err.stack
            done(err)
