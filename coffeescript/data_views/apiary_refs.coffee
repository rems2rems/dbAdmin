module.exports = 
    _id : '_design/refs'
    views :

        apiary :

            map : ((doc)-> 
                if doc.apiary_id?
                    emit doc.apiary_id,doc
                ).toString()