module.exports = (secu,dbName)->

    for role,i in secu.admins.roles
        secu.admins.roles[i] = dbName + "/" + role
    for role,i in secu.members.roles
        secu.members.roles[i] = dbName + "/" + role
    return secu
