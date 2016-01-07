module.exports = 
    _id : '_design/location'
    views :

        weather :

            map : ((doc)-> 
                if doc.type == "measure" and doc.apiary_id? and not doc.beehouse_id?
                    emit doc.apiary_id, doc
                ).toString()