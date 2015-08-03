prompt = require 'prompt'
insert_location = require '../../openbeelab-db-util/javascript/insert_location'
Promise = require 'promise'

module.exports = (db)->

    return new Promise((fulfill,reject)->
        prompt.start()
        prompt.get ['location_name'],(err,result)->
            if(err)
                reject(err)

            insert_location(db,result.location_name).then(fulfill,reject)
    )