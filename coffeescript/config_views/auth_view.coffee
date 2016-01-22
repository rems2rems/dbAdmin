module.exports =

    _id : '_design/auth'

    views : {}
    validate_doc_update : ((newDoc, oldDoc, userCtx)->

            isLogged = userCtx.name? and userCtx.name != ''

            if not isLogged
                throw({'forbidden': 'please log in.'})

            deletion = oldDoc.deleted or oldDoc._deleted
            creation = oldDoc is null
            update = not (creation or deletion)
            isAdmin = userCtx.roles.some (dbAndRole)->
                [db,role] = dbAndRole.split("/")
                return db is userCtx.db role is "admin"
            isMember = userCtx.roles.some (dbAndRole)->
                [db,_] = dbAndRole.split("/")
                return db is userCtx.db
            isUploader = userCtx.roles.some (dbAndRole)->
                [db,_] = dbAndRole.split("/")
                return db is userCtx.db
            
            if not Admin
                throw({'forbidden': "you're not a member."})

        ).toString()