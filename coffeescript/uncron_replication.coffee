fs = require 'fs'
require "../../util/javascript/stringUtils"
arrayUtils = require "../../util/javascript/arrayUtils"
mixin = require "../../util/javascript/mixin"
mixin.include Array,arrayUtils

fs.readFile "/var/spool/cron/crontabs/remy",'utf8',(err,crontab)->

    lines = crontab.split("\n")

    taskDescription = "#openbeelab database replication task"
    task = "_replicate "

    scriptIsCroned = lines.some((line)-> line.contain(taskDescription))

    if not scriptIsCroned

        console.log "script is not croned. exiting."

    else

        lines = lines.filter((line)-> not line.contain(taskDescription) and not line.contain(task))

        if lines.last().isEmpty()
            lines.pop()
        
        fs.writeFile "/etc/crontab",lines.join("\n"),'utf8'