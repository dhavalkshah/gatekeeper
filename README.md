# Gatekeeper

# [Postgres](./postgres/postgres.md)
DB is a must for every component of the Gatekeeper.
Choice of DB can be independent for each of the component, but is required. We are choosing postgres for it being freely available compatible to each of the component.

__version__ : 9.5


# [KeyCloak](./keycloak/KeyCloak.md)


# Gatekeeper setup steps
- Start / Create PG Database [link](./postgres/postgres.md)
- Create DB for KeyCloak and provide its configuration in [Keycloak's env](./keycloak/keycloak_env.list)
- Start Keycloak. Starting it for the 1st time, we will have to give it sometime to bootstrap. It will internally run the migrations and create the required tables.