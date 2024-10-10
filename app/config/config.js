const cfg = {
    "server": {
      "host": "app",
      "port": 3001,
      "appContextPath":"/app"
    },
    "keycloak": {
        "realm": process.env.KC_REALM,
        "authServerUrl": process.env.KC_AUTH_SERVER_URL,
        "sslRequired": "external",
        "resource": process.env.KC_RESOURCE,
        "clients": {
            "virtuapp":{
                "secret": process.env.KC_VIRTU_SECRET
            },
            "virtuservice":{
                "secret": process.env.KC_VIRTUSERVICE_SECRET
            }
        },
        "credentials": {
            "secret": process.env.KC_SECRET
        },
        "confidentialPort": 0,
        "clientId":process.env.KC_CLIENT_ID,
        "redirectUri": "http://localhost:3000/auth/callback"
    }
}

module.exports = {
    cfg
}