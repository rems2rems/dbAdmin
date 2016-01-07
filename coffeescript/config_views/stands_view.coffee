module.exports = 
    _id : '_design/stands'
    views :
        all :
            map : ((doc)-> 
                if doc.type == "stand"
                    emit doc._id,doc

                ).toString()

        by_beehouse :
            map : ((doc)-> 
                if doc.type == "stand" and doc.beehouse_id?
                    emit doc.beehouse_id,doc
                    
                ).toString()

        by_location :
            map : ((doc)-> 
                if doc.type == "stand" and doc.location_id?
                    emit doc.location_id,doc

                ).toString()