dbConfig = require './config'

dbDriver = require('../../dbUtil/javascript/dbUtil').configuredDriver(dbConfig.databases.local)
create_database = require '../../dbUtil/javascript/create_database'
prompt = require 'prompt'

module.exports = (callback)->
    prompt.start()
    prompt.get ['db_name'],(err,result)=>
        
        db = create_database dbDriver,result.db_name
        callback(db)