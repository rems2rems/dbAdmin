fs = require 'fs'
require "../../util/javascript/stringUtils"
arrayUtils = require "../../util/javascript/arrayUtils"
mixin = require "../../util/javascript/mixin"
mixin.include Array,arrayUtils

config = require './config'

fs.readFile "/var/spool/cron/crontabs/remy",'utf8',(err,crontab)->

    if err?
        console.log err
        return

    taskDescription = "#openbeelab database replication task"

    lines = crontab.split("\n")

    if lines.some((line)-> line.contain(taskDescription))

        console.log "script is already croned. exiting."
        return

    else

        if config.databases.replicationInterval.unit.startWith 'day'

            days = "*/" + config.databases.replicationInterval.value
            minutes = "*"

        else

            days = "*"
            minutes = "*/" + config.databases.replicationInterval.value


        replicationCommand = """
        curl -X POST http://admin:c0uchAdm1n@77.207.158.40:5984/_replicate 
        -d '{
        "source":"http://dev.openbeelab.org:5984/la_mine", 
        "target":"http://admin:c0uchAdm1n@77.207.158.40:5984/la_mine"
        }' 
        -H "Content-Type: application/json"
        """.replaceAll("\n"," ")

        lines.push taskDescription
        lines.push days + " " + minutes + " * * * " + replicationCommand
        lines.push ""

        fs.writeFile "/etc/crontab",lines.join("\n"),'utf8'