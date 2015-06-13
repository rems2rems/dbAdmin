dbConfig = require './config'
db = require('../../dbUtil/javascript/dbUtil').database(dbConfig.databases.local)
moment = require 'moment'

measuresUrl = '_design/measures/_view/by_date?startkey=\"2014-04-07T05\"' #&endkey=\"2014-05-07T14\"' #?key="'+ dbConfig.apiary_name+'"'

console.log "fetching measures..."

db.get measuresUrl,(err,measures)->

    #console.log err
    measures = measures.rows
    console.log "measures loaded!"
    console.log measures.length

    measures10 = [] #measures #[]
    nbMeasures = 10
    for i in [0...(measures.length-nbMeasures)] by nbMeasures

        measure = 0
        for j in [0...nbMeasures]

            measure += measures[i+j].value.value

        measure /= nbMeasures
        measures10.push {key : measures[i+nbMeasures].key, value : {value : measure}}

    console.log measures10.length
    for i in [0...(measures10.length-1)]

        #console.log measures[i].value
        if measures10[i+1].value.value > (measures10[i].value.value + 3) and measures10[i+1].value.value < (measures10[i].value.value + 7)

            m1 = moment(measures10[i].key)
            m2 = moment(measures10[i+1].key)

            console.log "box added:"
            console.log "before: " + m1.format() + " , value: " + measures10[i].value.value
            console.log "after:  " +  m2.format() + " , value: " + measures10[i+1].value.value 
            console.log "duration: " + Math.floor(moment.duration(m2.diff(m1)).asMinutes()) + " min\n\n"

        if measures10[i+1].value.value < (measures10[i].value.value - 4) and measures10[i+1].value.value > (measures10[i].value.value - 25)

            m1 = moment(measures10[i].key)
            m2 = moment(measures10[i+1].key)

            console.log "box removed:"
            console.log "before: " + m1.format() + " , value: " + measures10[i].value.value
            console.log "after:  " +  m2.format() + " , value: " + measures10[i+1].value.value 
            console.log "duration: " + Math.floor(moment.duration(m2.diff(m1)).asMinutes()) + " min\n\n"