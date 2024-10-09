# Kong

This is a custom Kong setup. It is based on Kong-gateway 3.1 (community edition).
The custom kong will have OIDC plugin and JWT plugin.
These plugins help in centralising and controlling access management for APIs.

# Cust OIDC Plugin
The OIDC plugin is based on [Nokia/Kong-oidc](https://github.com/nokia/kong-oidc).

This OIDC plugin was not compatible directly with the Kong version and hence we had to implement te same in our custom Kong.


# Cust JWT Plugin
The JWT plugin is based on [Kong Plugin JWT KeyCloak](https://github.com/sezane/kong-plugin-jwt-keycloak-v2/tree/master)

This Kong Plugin JWT Keycloak was not compatible directly with Kong version and hence we had to implement the same in our custom Kong.

Environment Variables
-----------------------------
These are to be set in the [env file](./kong_env.list)

Sr.no | Name|Desc
------|-----|------------------
1|KONG_DATABASE| Type of database. postgres in our case
2|KONG_PG_DATABASE| Name of the database
3|KONG_PG_HOST| IP or Host where the DB service is running.
4|KONG_PG_USER| DB User
5|KONG_PG_PASSWORD| DB User's password
6|KONG_ADMIN_GUI_URL| URL & Port where the Admin portal will be available
7|KONG_LOG_LEVEL| Optional, use debug only if you have to see Kong detail logs. 

# Build
The below command will create a custom image of Kong.

```
sh build-cust-kong.sh
```

# Bootstrap
For Kong to run efficiently, it needs to be seeded. This step ensures all the relevant tables are created and seeded in DB

```
sh bootstrap-kong.sh
```

# Start Kong
Start Kong using the newly created custom image.
```
sh start-kong.sh
```

## Validation of plugins being installed.
Use the below curl command to check the plugins installed in the custom Kong.
```
curl --location 'http://localhost:8001'
```
In the response json that you receive you must be able to see mention of both our custom plugins.
```
        "plugins": [
            "bundled",
            "cust-oidc",
            "cust-jwt"
        ]
```
Both the plugins will be enabled as well.