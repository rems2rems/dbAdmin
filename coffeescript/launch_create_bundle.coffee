
config = require './config'
create_bundle = require './create_bundle'
dbServer = require('../../openbeelab-db-util/javascript/dbDriver').connectToServer(config.database)
create_bundle(config,dbServer)