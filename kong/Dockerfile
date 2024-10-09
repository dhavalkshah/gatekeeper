FROM kong/kong-gateway:3.1
LABEL description="Kong  + kong-oidc plugin"
USER root
RUN apt-get update
RUN apt-get -y install git unzip curl 
RUN apt-get -y install zip

COPY ./cust-oidc/kong/plugins/cust-oidc /usr/local/share/lua/5.1/kong/plugins/cust-oidc
COPY ./cust-jwt/kong/plugins/cust-jwt /usr/local/share/lua/5.1/kong/plugins/cust-jwt
RUN luarocks install lua-resty-session 3.10
RUN luarocks install lua-resty-openidc 1.7.6

ENV KONG_PLUGINS=bundled,cust-oidc,cust-jwt

# Ensure kong user is selected for image execution
USER kong

# Run kong
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 8000 8443 8001 8444
STOPSIGNAL SIGQUIT
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD kong health
CMD ["kong", "docker-start"]

USER root