prompt = require 'prompt'
insert_apiary = require '../../openbeelab-db-util/javascript/insert_apiary'
Promise = require 'promise'

module.exports = (db,location)->

    return new Promise((fulfill,reject)->
        prompt.start()
        prompt.get ['apiary_name'],(err,result)->

            if(err)
                reject(err)

            apiaryPromise = insert_apiary db,result.apiary_name,location
            apiaryPromise.then (apiary)->

                view =
                    _id : '_design/' + apiary._id
                    views :

                        weather :

                            map : ((doc)-> 
                                if doc.type is "measure" and doc.name is "weather" and doc.apiary_id is "id_placeholder"
                                    
                                    emit(doc.timestamp, doc)

                                ).toString().replace("id_placeholder",apiary._id)

                        beehouses :

                            map : ((doc)-> 
                                if doc.type is "beehouse" and doc.apiary_id is "id_placeholder"
                                    
                                    emit(doc._id, doc)

                                ).toString().replace("id_placeholder",apiary._id)

                return db.save view

            apiaryPromise.then fulfill,reject
    )