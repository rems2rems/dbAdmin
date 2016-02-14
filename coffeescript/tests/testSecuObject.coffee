
expect = require 'must'
require('../../../openbeelab-util/javascript/objectUtils').install()
require('../../../openbeelab-util/javascript/arrayUtils').install()

config = require('../config')

buildDbSecurityObject = require '../buildDbSecurityObject'

describe "a security object", ->

    it "should be made for a specific db", (done)->
       
        secu = config.database.securityObject
        secu = buildDbSecurityObject(secu,"testDb")
        
        secu.admins.names.length.must.be(1)
        secu.admins.names[0].must.be("admin")
        secu.admins.roles.length.must.be(1)
        secu.admins.roles[0].must.be("testDb/admin")

        secu.members.names.length.must.be(0)
        secu.members.roles.length.must.be(2)
        secu.members.roles.must.contain("testDb/beekeeper")
        secu.members.roles.must.contain("testDb/uploader")
        done()
