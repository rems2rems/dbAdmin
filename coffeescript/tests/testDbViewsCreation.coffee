
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()

config = require('../config')
promisify_db = require '../../../openbeelab-db-util/javascript/promisify_dbDriver'

dbDriver = require('../../../openbeelab-db-util/javascript/mockDriver')
Promise = require 'promise'

configDb = dbDriver.connectToServer(config).useDb(config.database.name + "_config")
dataDb = dbDriver.connectToServer(config).useDb(config.database.name + "_data")

createViews = require '../create_views'

describe "create views for the config db",->

    it "should create all expected views", (done)->

        createViews(configDb,"config")
        .then ()->
            
            configDb.get('_design/stands/_view/all').then (data)->

                data.total_rows.must.be.at.least(1)

        done()
