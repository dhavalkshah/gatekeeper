# Keycloak

We are adding context path as `/kc`

To start the docker just run:
```
sh start-keycloak.sh
```

Environment Variables
-----------------------------

Sr.no | Name|Desc
------|-----|------------------
1|KC_DB| The type of DB that is used for Keycloak. Valid values can be checked from https://www.keycloak.org/server/db
2|KC_DB_USERNAME|Username
3|KC_DB_PASSWORD|Password
4|KC_DB_URL_PORT|Port on which DB is running
5|KC_DB_URL|JDBC URL of the DB
6|KC_HTTP_PORT | Port on which Keycloak is available
7|KC_HTTP_RELATIVE_PATH | Context path for Keycloak. 

### Configuring KeyCloak
- Create a realm specific to your usage. e.g. I have created a realm named "Virtu"
    - Realm Settings --> Tokens --> Access Token (section) = set the TTL for the access token
- Create a client. e.g. "virtuservice"
    - Client ID - virtuservice
    - Client Authentication - on
    - Authentication flow - Standard flow, Direct access grant & Service accounts roles.
- On the Credential tab, there is a Client Secret. Store it securely. It will be needed in Auth application [configuration](../auth/config/config.js) 
- Create a user-defined variable which we want to be part of token generated for our application users
    - Realm Settings --> User Profile --> Create Attribute. For my example I have set the below values
        - name = org_id
        - Required field = true
        - Permission to edit -> All
- Add the user defined variable to client scope
    - Client Scopes --> profile --> Mapper
    - Mappers --> Add mapper --> By Configuration --> User Attribute. Edit the config as
        - name = org_id
        - select org_id from User Attribute drop down
        - Token Claim name - org_id --> this is the attribute that will be visible in the access token
        - Add to lightweight access token - set to true
- Create realm roles - I created 3 realm roles viz. admin, manager, 3ddesigner.
- Create 3 users viz. virtuadmin, virtumanager & virtudesigner.. Set the following attributes for all the users
    - username
    - Email
    - First Name
    - Last Name
    - org_id
    - Email verified --> set to True
- For all the 3 users set the following
    - Email verified - On
    - Credentials --> Set Password --> Temporary (off/false)
    - Role Mapping --> Assign Roles --> Change the filter to "Filter by realm roles". Choose the relevant roles
        - virtuadmin mapped to manager, admin & 3ddesigner roles
        - virtumanager mapped to only manager role
        - virtudesigner mapped to only 3ddesigner role


Once the above setup is done, test the user login, using below curl
```
curl --location 'http://keycloak:8180/kc/realms/Virtu/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'username=virtuadmin' \
--data-urlencode 'password=virtuadmin@123' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'client_id=virtuservice' \
--data-urlencode 'client_secret=c9ozNmm92iv9Qfc8BpEZAe2ra1J46Bbb' \
--data-urlencode 'scope=openid'
```

