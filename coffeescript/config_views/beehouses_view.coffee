module.exports = 
    _id : '_design/beehouses'
    views :
        all :
            map : ((doc)-> 
                if doc.type == "beehouse"
                    emit doc._id,doc
                ).toString()

        by_name :
            map : ((doc)-> 
                if doc.type == "beehouse"
                    emit doc.name,doc

                ).toString()

        by_apiary :
            map : ((doc)-> 
                if doc.type == "beehouse" and doc.apiary_id?
                    emit doc.apiary_id,doc
                ).toString()

        by_location :
            map : ((doc)-> 
                if doc.type == "beehouse" and doc.location_id?
                    emit doc.location_id,doc
                ).toString()