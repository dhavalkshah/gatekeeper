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