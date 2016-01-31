
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()

config = require('../config')
#promisify_db = require '../../../openbeelab-db-util/javascript/promisify_dbDriver'

dbDriver = require('../../../openbeelab-db-util/javascript/mockDriver')
Promise = require 'promise'

dbServer = dbDriver.connectToServer(config.database)
usersDb = dbServer.useDb("_users")
#dataDb = dbDriver.connectToServer(config.database).useDb(config.database.name)

createUsers = require '../create_users'

describe "an admin and an uploader for a db",->

    before (done)->
        
        usersDb.create()
        .then(done)
        .catch (err)-> console.log(err); done(err)

    after (done)->

        dbServer.deleteDb("_users")
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

