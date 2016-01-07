module.exports = 
    _id : '_design/measures'
    views :

        all :
            map : ((doc)-> 
                if doc.type == "measure"
                    emit doc._id,doc

                ).toString()

        by_date :
            map : ((doc)-> 
                if doc.type == "measure"
                    emit doc.timestamp,doc

                ).toString()

        by_location :
            map : ((doc)-> 
                if doc.type == "measure" and doc.location_id?
                    emit doc.location_id,doc

                ).toString()

        by_beehouse :
            map : ((doc)-> 
                if doc.type == "measure" and doc.beehouse_id?
                    emit doc.beehouse_id,doc

                ).toString()

        by_location_date_name :
            map : ((doc)-> 
                if doc.type == "measure" and doc.location_id?
                    emit [doc.location_id,doc.timestamp,doc.name],doc

                ).toString()

        by_location_date_beehouse :
            map : ((doc)-> 
                if doc.type == "measure" and doc.location_id? and doc.beehouse_id?
                    emit [doc.location_id,doc.timestamp,doc.beehouse_id],doc

                ).toString()

        by_location_date_beehouse_name :
            map : ((doc)-> 
                if doc.type == "measure" and doc.location_id? and doc.beehouse_id?
                    emit [doc.location_id,doc.timestamp,doc.beehouse_id,doc.name],doc

                ).toString()