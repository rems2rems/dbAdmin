module.exports =

    _id : '_design/auth'

    views : {}
    validate_doc_update : ((newDoc, oldDoc, userCtx,secObj)->
            
            isServerAdmin = userCtx.roles?.indexOf("_admin") != -1
            
            if isServerAdmin
                return

            isLogged = userCtx.name != ''
            hasAdminRole = isLogged and (userCtx.roles.filter((role)-> return secObj.admins.roles.indexOf(role) != -1).length > 0)
            isAdmin = isLogged and (secObj.admins.names.indexOf(userCtx.name) != -1)
            isAdmin = isAdmin or hasAdminRole

            if isAdmin
                return
            
            hasMemberRole = isLogged and (userCtx.roles.filter((role)-> return secObj.members.roles.indexOf(role) != -1).length > 0)
            isMember = isLogged and (secObj.members.names.indexOf(userCtx.name) != -1)
            isMember = isMember or hasMemberRole

            if not isMember
                throw({'forbidden': 'you are not allowed to modify this database.'})

            isDeletion = newDoc.deleted or newDoc._deleted
            isCreation = oldDoc is null
            isUpdate = not (isCreation or isDeletion)
            
            dbName = userCtx.db.split("_config")[0]
            isUploader = userCtx.roles.some (dbAndRole)->
                [db,role] = dbAndRole.split("/")
                return (db is dbName) and (role is "uploader")
            
            if isUploader
                throw({'forbidden': "you can only read config."})

        ).toString()
