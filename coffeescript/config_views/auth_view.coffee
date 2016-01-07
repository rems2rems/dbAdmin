module.exports =

    _id : '_design/auth'

    views : {}
    validate_doc_update : ((newDoc, oldDoc, userCtx)->

        isLogged = userCtx.name? and userCtx.name != ''
        
        if not isLogged
            throw({'forbidden': 'please log in.'})

        ).toString()