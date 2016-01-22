dbConfig = require './config'
db = require('../../openbeelab-db-util/javascript/dbDriver').useDb(dbConfig.databases.local.db)

prompt = require 'prompt'

insertFn = require('./insert_' + process.argv[2])

insertFn db,null,(err,res)->

    console.log err
    console.log res