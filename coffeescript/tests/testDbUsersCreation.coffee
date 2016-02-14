
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()

config = require('../config')

mockCouch = require('../../../mock-couch')

dbDriver = require('../../../openbeelab-db-util/javascript/dbDriver')
Promise = require 'promise'


createUsers = require '../create_users'

describe "an admin and an uploader for a db",->
        
    instance = null
    dbServer = null
    usersDb = null

    before (done)->
        
        instance = mockCouch.createServer()
        instance.listen(config.database.port)
        instance.addDB("_users")
        
        dbServer = dbDriver.connectToServer(config.database)
        usersDb = dbServer.useDb("_users")
        done()

    after (done)->

        instance.close()
        done()
    
    it "should be created", (done)->
        
        createUsers(usersDb,config.database.name)
        .then (users) ->
        
            adminProm = usersDb.get(users.admin._id)
            uploaderProm = usersDb.get(users.uploader._id)
            return Promise.all([adminProm,uploaderProm])
        
        .then ([admin,uploader])->

            admin.name.must.be(config.database.name+"_admin")
            admin._id.must.be("org.couchdb.user:" + config.database.name+"_admin")
            admin.roles.must.contain(config.database.name+"/admin")


            uploader.name.must.be(config.database.name+"_uploader")
            uploader._id.must.be("org.couchdb.user:" + config.database.name+"_uploader")
            uploader.roles.must.contain(config.database.name+"/uploader")
            done()

        .catch (err)->
            
            console.log('err: ' + err)
            done(err)

