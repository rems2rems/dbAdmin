dbDriver = require '../../openbeelab-db-util/javascript/dbDriver'
dbConfig = require './config'
db = dbDriver.connectToServer(dbConfig.database).useDb(dbConfig.database.name)

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