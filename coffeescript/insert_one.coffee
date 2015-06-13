dbConfig = require './config'
db = require('../../dbUtil/javascript/dbUtil').database(dbConfig.databases.local.db)

prompt = require 'prompt'

insertFn = require('./insert_' + process.argv[2])

insertFn db,null,(err,res)->

    console.log err
    console.log res