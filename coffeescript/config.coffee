module.exports =

    databases :

        local :

            #host : 'dev.openbeelab.org'
            host : 'localhost'
            protocol : 'http'
            port : 5984
            auth:
                username: 'admin'
                password: 'c0uchAdm1n'
            name : 'la_mine_dev'
            #apiary_name : 'remy-rucher-1'
            apiary_name : 'la_mine_rucher_01'

        remote :
            
            host : 'dev.openbeelab.org'
            #host : 'localhost'
            protocol : 'http'
            port : 5984
            auth:
                username: 'admin'
                password: 'c0uchAdm1n'
            name : 'la_mine'

        replicationInterval :

            value : 10
            unit : 'minutes'
    
    external_sites:
        - 'openweathermap'
