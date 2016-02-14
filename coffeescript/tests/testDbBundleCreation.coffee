
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()

config = require('../config').clone()

createBundle = require '../create_bundle'

dbDriver = require('../../../openbeelab-db-util/javascript/dbDriver')
Promise = require 'promise'

instance = null

describe "create a bundled db",->

    before (done)->
        
        mockCouch = require('../../../mock-couch')
        instance = mockCouch.createServer()
        instance.listen(config.database.port)
        instance.addDB("_users")
        done()

    after (done)->

        instance.close()
        done()
    
    it "should work", (done)->

        dbServer = dbDriver.connectToServer(config.database)
        createBundle(config,dbServer)
        .then (logs)->
            
            expect(logs).to.not.be(null)
            logs.length.must.be.above(5)
            configDb = dbServer.useDb(config.database.name + "_config")
            dataDb = dbServer.useDb(config.database.name + "_data")
            usersDb = dbServer.useDb("_users")
            
            configDb.exists().must.eventually.be.true()
            dataDb.exists().must.eventually.be.true()
            usersDb.get('org.couchdb.user:' + config.database.name + '_admin').must.eventually.not.be(null) 
            done()

        .catch (err)->
            
            done(err)
