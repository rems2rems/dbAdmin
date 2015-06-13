prompt = require 'prompt'
insert_sensor = require '../../dbUtil/javascript/insert_sensor'

module.exports = (db,beehouse,callback)->

    prompt.start()
    prompt.get ['pcduinopin','bias','gain','sensor_name','unit'],(err,result)=>
        
        insert_sensor db,beehouse,parseInt(result.pcduinopin),parseInt(result.bias),parseFloat(result.gain),result.sensor_name,result.unit,callback