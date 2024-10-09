# Postgres

We are using postgres DB for all the components of Gatekeeper.
But it is not mandatory to use postgresql. Each component can have their own DBs.


**If the database is independent, we need to ensure that the DB is reachable from each of the component.**

Once the DB is up and running, we will have to create DBs for each of the component.

To start pgsql in docker env
```
sh start-pg.sh
```