
bunyan = require 'bunyan'
module.exports = (name)-> bunyan.createLogger({name: name,level:'debug'})
