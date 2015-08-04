module.exports =

    databases :

        local :

            #host : 'dev.openbeelab.org'
            host : 'localhost'
            protocol : 'http'
            port : 5984
            auth:
                username: 'admin'
                password: 'xxx'
            name : 'le_bel_ordinaire_dev'
            #apiary_name : 'remy-rucher-1'
            apiary_name : 'le_bel_ordinaire_001'
            location :
                name : "le_bel_ordinaire"
                locationType : "GPS"
                latitude : 43.301854
                longitude : -0.399957
                create_noised_area : true
                noise : 0.0166666667 #degree = 1 minute
            beehouse :
                name : 'mybeehouse_001'
                model :
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
            stand :
                name : "protopierre_001"
                type : "stand"
                device : "arietta_g25"
                sensors : [
                    active : true
                    name : "global-weight"
                    type : "romanScale"
                    motor :
                        directionPinId : 45
                        pulsePinId : 46
                    photoDiode :
                        pinId : "in_voltage0_raw"
                ]

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
