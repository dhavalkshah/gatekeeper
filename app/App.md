# Application

Application here is like any other business application, it will expose its APIs.
These APIs will be secured via Kong API gateway.

## Build
```
sh build-app.sh
```

## Start App
```
sh start-app.sh
```

For sample we have created a dummy API, details are:

route: /app/getCustomerData

Response: message --> received the request successfully

It will log the request and headers that it receives.

### Before securing the API
```
curl --location 'http://localhost:8000/app/getCustomerData' \
--header 'Content-Type: application/json' \
--data '{
    "key1":"value1",
    "key2":"value2"
}'
```

Response

```
{
    "message": "received the request successfully"
}
```

