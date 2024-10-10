# Auth

This is a sample nodejs application to interact with KeyCloak.

The real plan for us was to have our custom-ui and not depend on the UI being provided by KeyCloak for login. Thus, API from our UI will be used to take the login request. Login API will further interact with Keycloak to login the user and return the token request.

### Config
Parameter|Description
---------|-----------------------------
server.host|Host on which the Auth application will be accessible. e.g. localhost or service name used while standing up the docker image
server.port| Port on which the Auth application will be listening for request. e.g. 3000
server.contextPath| Context path of the application. This is must and should match to the path which will be used for routing the request in Kong to Auth application
keycloak.realm| Realm name of Keycloak
keycloak.authServerUrl| Base URL for KeyCloak e.g. http://keycloak:8180/kc/
keycloak.clients[clientId] | The client Id created in Keycloak
keycloak.clients[clientId].secret | Respective secret of the client.


The sample config will look like
```
{
    "server": {
      "host": "auth",
      "port": 3000,
      "contextPath":"/auth",
    },
    "keycloak": {
        "realm": process.env.KC_REALM,
        "authServerUrl": process.env.KC_AUTH_SERVER_URL,
        "clients": {
            "virtuservice":{
                "secret": process.env.KC_VIRTUSERVICE_SECRET
            }
        }
    }
}
```

# Build
```
sh build-auth.sh
```

# Start Auth Application
```
sh start-auth.sh
```

# APIs

### Login (route: /auth/login/{KeyCloakClientId})

Based on the KeyCloak client id, the application will fetch the secret and try a login. Further it relays the response of the KeyCloak token API. 

e.g.
```
curl --location 'http://localhost:8000/auth/login/virtuservice' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"virtuadmin",
    "password":"virtuadmin@123"
}'
```
