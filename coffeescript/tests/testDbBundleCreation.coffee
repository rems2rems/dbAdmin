
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

util = require 'util'

describe "create a bundled db",->

    before (done)->
        
        dbServer.useDb("_users").create()
        .then(done)
        .catch (err)-> console.log(err); done(err)

    after (done)->

        #try
        dbServer.deleteDb(config.database.name + "_config")
        dbServer.deleteDb(config.database.name + "_data")
        dbServer.deleteDb("_users")
        done()
        #catch err
        #    console.log(err)
    
    it "should work", (done)->

        createBundle(config,dbServer)
        .then ->
            
            configDb = dbDriver.connectToServer(config.database).useDb(config.database.name + "_config")
            dataDb = dbDriver.connectToServer(config.database).useDb(config.database.name + "_data")
            usersDb = dbDriver.connectToServer(config.database).useDb("_users")
            
            configDb.exists().must.eventually.be.true()
            dataDb.exists().must.eventually.be.true()
            
#            console.log util.inspect(usersDb.data,true,5,true)
#            usersDb.get("org.couchdb.user:" + config.database.name + "_admin")
#            .then (user)->
#
#                user.name.must.be(config.database.name + "_admin")

#           .then ()->
                
#                usersDb.get("org.couchdb.user:" + config.database.name + "_uploader")
            
#            .then (user)->

#                user.name.must.be(config.database.name + "_uploader"
            done()

        .catch (err)->
            
            done(err)
