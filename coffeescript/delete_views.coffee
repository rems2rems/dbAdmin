fs = require 'fs'
Promise = require 'promise'
      
module.exports = (db,category)->

    return new Promise((fulfill,reject)->

        fs.readdir (__dirname + "/" + category + "_views"),(err,filenames)=>
            
            if(err)
                reject(err)
                return

            promise = Promise.all(filenames.map((filename)->

                view = require "./" + category + "_views/"+filename.split(".")[0]
                return db.delete view
                )
            )

            promise.then (views)->
                fulfill(views)
    )
    

            

