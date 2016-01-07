dbDriver = require '../../openbeelab-db-util/javascript/dbUtil'
dbConfig = require './config'
db = dbDriver.database(dbConfig.databases.local)
getWeekNumber = require('../../util/javascript/dateUtil').getWeekNumber

measuresUrl = "_design/measures/_view/by_date?startkey=\"2014-12-29T05:15:00.000Z\"&limit=1" #&startkey=\"W30\"
db.get measuresUrl,(err,rows)->

    # console.log rows.length
    # console.log rows[0]
    # console.log rows[measures.length-1]

    for row in rows

        measure = row.value
        console.log getWeekNumber(new Date(measure.timestamp))
        # db.remove measure._id,measure._rev,(err,res)->

        #     console.log "measure " + measure._id + " deleted."
        #     if err?
        #         console.log(err)
        #     else
        #         console.log(res)