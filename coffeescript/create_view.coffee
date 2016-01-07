
dbConfig = require './config'
db = require('../../openbeelab-db-util/javascript/dbUtil').database(dbConfig.database)

view = require "./" + process.argv[2]
console.log view

db.save view
.then (res)->
    
    console.log res
