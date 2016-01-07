dbDriver = require '../../openbeelab-db-util/javascript/dbUtil'
dbConfig = require './config'
db = dbDriver.database(dbConfig.database)

measuresUrl = "_design/measures/_view/all"

apiary = null
db.get measuresUrl,(err,rows)->

    for row in rows

        measure = row.value

        if measure.beehouse_id

            db.get measure.beehouse_id,(err,beehouse)->

                bh = {_id: beehouse._id, name : beehouse.name}
                measure.beehouse = bh
                delete measure.beehouse_id
                db.save measure