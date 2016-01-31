
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()

config = require('../config')
promisify_db = require '../../../openbeelab-db-util/javascript/promisify_dbDriver'

dbDriver = require('../../../openbeelab-db-util/javascript/mockDriver')
Promise = require 'promise'

dbServer = dbDriver.connectToServer(config)
configDb = dbServer.useDb(config.database.name + "_config")
dataDb = dbServer.useDb(config.database.name + "_data")

createViews = require '../create_views'

describe "create views for the config db",->
    
    before (done)->
        
        configDb.create()
        .then(done)
        .catch (err)-> console.log(err); done(err)

    after (done)->

        dbServer.deleteDb(config.database.name + "_config")
        done()

    it "should create all expected views", (done)->
        
        createViews(configDb,"config")
        .then ()->
        
            configDb.save { _id : "test_stand", type : 'stand', name:'a test stand'}
       
        .then ()->
             
            configDb.save { _id: 'test_location', type : 'location', name:'a test location'}
        
        .then ()->
            
            configDb.get('_design/stands/_view/all')
        
        .then (data)->

            data.total_rows.must.be(1)
            done()
        
        .catch (err)->

            done(err)

describe "create views for the data db",->
    
    before (done)->
        
        dataDb.create()
        .then(done)
        .catch (err)-> console.log(err); done(err)

    after (done)->

        dbServer.deleteDb(config.database.name + "_data")
        done()

    it "should create all expected views", (done)->
        
        createViews(dataDb,"data")
        .then ()->
        
            dataDb.save { _id : "test_measure", type : 'measure', name:'a test measure',value: 53.6}
       
        .then ()->
            
            dataDb.get('_design/measures/_view/all')
        
        .then (data)->

            data.total_rows.must.be(1)
            done()
        
        .catch (err)->

            done(err)
