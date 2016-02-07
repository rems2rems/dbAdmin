
config = require './config'
create_bundle = require './create_bundle'
try
    dbServer = require('../../openbeelab-db-util/javascript/dbDriver').connectToServer(config.database)
    process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0'
    create_bundle(config,dbServer)
catch err
    console.log err
