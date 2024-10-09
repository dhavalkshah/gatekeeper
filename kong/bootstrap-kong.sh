docker-compose -f ./docker-compose-kong.yml run --rm kong kong migrations bootstrap
# docker-compose -f ./docker-compose-kong.yml up -d