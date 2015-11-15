module.exports =

    databases :

        local :

            host : 'dev.openbeelab.org'
            #host : 'localhost'
            protocol : 'http'
            port : 5984
            auth:
                username: 'admin'
                password: 'xxx'
            name : 'xxx'
            apiary :
                _id : "apiary:rucher_001"
                name : "rucher_001"
                type : "apiary"
                location : { _id : "location:jbc", name : "jbc" }
            location :
                _id : "location:jbc"
                name : "jbc"
                locationType : "GPS"
                latitude : 43.301854
                longitude : -0.399957
                create_noised_area : true
                noise : 0.0166666667 #degree = 1 minute
            beehouse_model :
                _id : "beehousemodel:dadant"
                name : "dadant"
                type : "beehousemodel"
                model : "dadant"
                weight :
                    value : 37
                    unit : "Kg"
                extra_box_weight :
                    value : 5
                    unit : "Kg"
            beehouse :
                _id : 'beehouse:ruche_001'
                name : 'ruche_001'
                model : { _id : "beehousemodel:dadant", name : "dadant" }
                apiary : { _id : "apiary:rucher_001", name : "rucher_001" }
                number_of_extra_boxes : 0
                has_roof : true
            stand :
                _id : "stand:socle_001"
                name : "socle_001"
                type : "stand"
                device : "arietta_g25"
                sensors : [
                    active : true
                    name : "global-weight"
                    process : "romanScale"
                    action : 'searchEquilibrium'
                    motor :
                        enable : 'J4.8'
                        ms1 : 'J4.10'
                        ms2 : 'J4.12'
                        ms3 : 'J4.14'
                        pulse : 'J4.28'
                        direction : 'J4.30'
                        sleep : 'J4.26'
                        reset : 'J4.24'

                    photoDiode1 : 'in_voltage0_raw'
                    photoDiode2 : 'in_voltage1_raw'
                ]
                sleepMode : true
                sleepDuration : 3300
                apiary : { _id : "apiary:rucher_001", name : "rucher_001" }
                beehouse : { _id : "beehouse:ruche_001", name : "ruche_001" }
                location : { _id : "location:jbc", name : "jbc" }

        # remote :
            
        #     host : 'dev.openbeelab.org'
        #     #host : 'localhost'
        #     protocol : 'http'
        #     port : 5984
        #     auth:
        #         username: 'admin'
        #         password: 'enter admin password here'
        #     name : 'la_mine'

        # replicationInterval :

        #     value : 10
        #     unit : 'minutes'
    
    # external_sites:
    #     - 'openweathermap'
