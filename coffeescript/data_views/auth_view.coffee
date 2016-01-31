module.exports =

    _id : '_design/auth'

    views : {}
    validate_doc_update : ((newDoc, oldDoc, userCtx)->

            isLogged = userCtx.name? and userCtx.name != ''

            if not isLogged
                throw({'forbidden': 'please log in.'})

            isDeletion = oldDoc.deleted or oldDoc._deleted
            isCreation = oldDoc is null
            isUpdate = not (creation or deletion)
            
            isAdmin = userCtx.roles.some (dbAndRole)->
                [db,role] = dbAndRole.split("/")
                return db is userCtx.db and role is "admin"
            isMember = userCtx.roles.some (dbAndRole)->
                [db,_] = dbAndRole.split("/")
                return db is userCtx.db
            isUploader = userCtx.roles.some (dbAndRole)->
                [db,role] = dbAndRole.split("/")
                return db is userCtx.db and role is 'uploader'

            if isAdmin
                return

            if isUploader and isCreation and newDoc.type is "measure"
                return

            throw({'forbidden': 'not enough rights'})
        
        ).toString()
