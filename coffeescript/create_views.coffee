db = require('../../dbUtil/javascript/dbUtil').database(require('../../config').databases.local)

module.exports = (db,callback)->

    sensors_views =
        _id : '_design/sensors'
        views :
            by_beehouse :
                map : ((doc)-> 
                    if doc.type == "sensor"
                        emit doc.beehouse.name,doc

                    ).toString()

            by_apiary :
                map : ((doc)-> 
                    if doc.type == "sensor"
                        emit doc.beehouse.apiary.name,doc

                    ).toString()

            by_location :
                map : ((doc)-> 
                    if doc.type == "sensor"
                        emit doc.beehouse.apiary.location.name,doc

                    ).toString()

    db.save sensors_views,=>
        #console.log "sensors views created."


        beehouses_views =
            _id : '_design/beehouses'
            views :
                by_name :
                    map : ((doc)-> 
                        if doc.type == "beehouse"
                            emit doc.name,doc

                        ).toString()

                by_apiary :
                    map : ((doc)-> 
                        if doc.type == "beehouse"
                            emit doc.apiary.name,doc

                        ).toString()

                by_location :
                    map : ((doc)-> 
                        if doc.type == "beehouse"
                            emit doc.apiary.location.name,doc

                        ).toString()

        db.save beehouses_views,=>
            #console.log "beehouses views created."

            apiaries_views =
                _id : '_design/apiaries'
                views :
                    by_name :
                        map : ((doc)-> 
                            if doc.type == "apiary"
                                emit doc.name,doc

                            ).toString()

                    by_location :
                        map : ((doc)-> 
                            if doc.type == "apiary"
                                emit doc.location.name,doc

                            ).toString()

            db.save apiaries_views,=>
                #console.log "apiaries views created."

                locations_views =
                    _id : '_design/locations'
                    views :
                        by_name :
                            map : ((doc)-> 
                                if doc.type == "location"
                                    emit doc.name,doc

                                ).toString()

                db.save locations_views,=>
                    #console.log "locations views created."


                    measures_views =
                        _id : '_design/measures'
                        views :
                            by_location :
                                map : ((doc)-> 
                                    if doc.type == "measure"
                                        emit doc.location.name,doc

                                    ).toString()

                            by_date :
                                map : ((doc)-> 
                                    if doc.type == "measure"
                                        emit doc.timestamp,doc

                                    ).toString()

                            by_name :
                                map : ((doc)-> 
                                    if doc.type == "measure"
                                        emit doc.name,doc

                                    ).toString()

                            by_location_and_date_and_name :
                                map : ((doc)-> 
                                    if doc.type == "measure"
                                        emit [doc.location.name,doc.timestamp,doc.name],doc

                                    ).toString()

                    db.save measures_views,callback #=>
                        #console.log "measures views created."