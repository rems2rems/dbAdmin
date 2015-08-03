prompt = require 'prompt'
insert_beehouse = require '../../openbeelab-db-util/javascript/insert_beehouse'
Promise = require 'promise'

module.exports = (db,apiary,callback)->

    return new Promise((fulfill,reject)->
        prompt.start()
        prompt.get ['location_name'],(err,result)->
            if(err)
                reject(err)

            return insert_location(db,result.location_name).then(fulfill)
    )


    prompt.start()
    prompt.get ['beehouse_name'],(err,result)->
        
        insert_beehouse db,apiary,result.beehouse_name,"dadant",(err,beehouse)->

            view = require './beehouse_view'
            db.save view, callback