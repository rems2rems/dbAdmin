# Copyright 2012-2014 OpenBeeLab.
# This file is part of the OpenBeeLab project.

# The OpenBeeLab project is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# The OpenBeeLab project is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with OpenBeeLab.  If not, see <http://www.gnu.org/licenses/>.

create_database = require './create_database'
#createViews = require '../../dbUtil/javascript/create_views'
insert_location = require './insert_location'
insert_apiary = require './insert_apiary'
# insert_beehouse = require './insert_beehouse'
# insert_sensor = require './insert_sensor'

create_database().then (db)->
    
    console.log "database created."
    return db

.then (db)->

    insert_location(db).then (location)->

        console.log "location created."
        
        insert_apiary db,location, (err,apiary)=>

        #     if err?
        #         console.log err
        #         return

        #     console.log "apiary created."
            
        #     insert_beehouse db,apiary,(err,beehouse)=>


        #         if err?
        #             console.log err
        #             return

        #         console.log "beehouse created."
                
        #         insert_sensor db,beehouse,(err,sensor)=>

        #             if err?
        #                 console.log err
        #                 return

        #             console.log "sensor created."