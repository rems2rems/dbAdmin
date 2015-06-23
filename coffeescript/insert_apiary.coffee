prompt = require 'prompt'
insert_apiary = require '../../dbUtil/javascript/insert_apiary'

module.exports = (db,location,callback)->

    prompt.start()
    prompt.get ['apiary_name'],(err,result)=>
        
        insert_apiary db,result.apiary_name,location,(err,apiary)->

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

            db.save view, callback