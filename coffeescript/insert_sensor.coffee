prompt = require 'prompt'
insert_sensor = require '../../openbeelab-db-util/javascript/insert_sensor'
Promise = require 'promise'

module.exports = (db,beehouse)->

    return new Promise((fulfill,reject)->
    	prompt.start()
	    prompt.get ['device','measureType','pin','bias','gain','sensor_name','unit'],(err,result)=>
	        
	        if err?
	        	reject(err)
	        
	        promise = insert_sensor db,beehouse,result.device,result.measureType,parseInt(result.pin),parseInt(result.bias),parseFloat(result.gain),result.sensor_name,result.unit
	        promise.then fulfill
	)