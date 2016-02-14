
dbConfig = require './config'
db = require('../../openbeelab-db-util/javascript/dbDriver').connectToServer(dbConfig.database).useDb(dbConfig.database.name)

view = require "./" + process.argv[2]
#console.log view

db.save view
#.then (res)->
#    
#    console.log res
