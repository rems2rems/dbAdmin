
dbConfig = require './config'
db = require('../../dbUtil/javascript/dbUtil').database(dbConfig.databases.local)

createView = require '../../dbUtil/javascript/create_view'

viewPath = "../../dbUtil/javascript/views/"+process.argv[2]

createView db,viewPath,(err,res)->
    
    console.log err
    console.log res

