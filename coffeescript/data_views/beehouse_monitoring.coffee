module.exports = 

    _id : '_design/beehouse_monitoring'
    views :

        new_relative_data :

            map : ((doc)->

                if doc.type == "measure" and doc.absolute_ref isnt undefined and doc.absolute_ref is null

                    emit doc.beehouse_id, doc

            ).toString()
        
        absolute_weight :

            map : ((doc)->

                if doc.type == "measure" and doc.name is 'global-weight'

                    emit [doc.beehouse_id,doc.timestamp], doc

            ).toString()
