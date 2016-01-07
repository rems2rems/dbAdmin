objectUtils = require '../../openbeelab-util/javascript/objectUtils'
objectUtils.install()

dbDriver = require '../../openbeelab-db-util/javascript/dbUtil'
dbConfig = require './config'

dataCfg = dbConfig.database.clone()
console.log dataCfg.name
dataDb = dbDriver.database(dataCfg)

configCfg = dbConfig.database.clone()
configCfg.name += "_config"
configDb = dbDriver.database(configCfg)

# dataDb.exists().then (exists)->
#     console.log exists

# http = require('http')
# http.get {
#         host: 'dev.openbeelab.org'
#         port : 5984
#         path: '/la_mine/_all_docs?startkey=\"_design/\"&endkey=\"_design0\"&include_docs=true'
#     }, (response) ->
#         body = ''
#         response.on 'data', (d) ->
#             body += d
        
#         response.on 'end', () ->

#             docs = JSON.parse(body).rows
#             console.log docs
#             for doc in docs
#                 do (doc)->
#                     doc = doc.doc
#                     delete doc._rev
#                     configDb.save doc

dataDb.get '_all_docs?startkey=\"_design/\"&endkey=\"_design0\"&include_docs=true'
#,(err,data)->
.then (data)->
    #console.log err
    console.log data
    rows = data.rows
    for row in rows

       console.log row._id