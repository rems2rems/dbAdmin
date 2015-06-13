prompt = require 'prompt'
insert_location = require '../../dbUtil/javascript/insert_location'

module.exports = (db,callback)->

	prompt.start()
	prompt.get ['location_name'],(err,result)->
	    
	    insert_location db,result.location_name,callback