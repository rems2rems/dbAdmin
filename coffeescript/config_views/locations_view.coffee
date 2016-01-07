module.exports = 
    _id : '_design/locations'
    views :
        all :
            map : ((doc)-> 
                if doc.type == "location"
                    emit doc._id,doc

                ).toString()