
require('../../openbeelab-util/javascript/stringUtils').install()

Promise = require 'promise'

module.exports = (usersDb,dbName)->

    dbAdmin =
        _id : 'org.couchdb.user:'+dbName+'_admin'
        type : "user"
        name : dbName+'_admin'
        roles : [dbName+'/admin']
        password : String.generateToken(6)

    adminPromise = usersDb.save dbAdmin

    dbUploader =

        _id : 'org.couchdb.user:'+dbName+'_uploader'
        type : "user"
        name : dbName+'_uploader'
        roles : [dbName+'/uploader']
        password : String.generateToken(6)

    uploaderPromise = usersDb.save dbUploader

    all = Promise.all [adminPromise,uploaderPromise]
    return all.then ()->
        
        return { admin : dbAdmin, uploader : dbUploader}
