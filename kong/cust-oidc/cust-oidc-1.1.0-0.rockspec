package = "cust-oidc"
version = "1.1.0-0"
source = {
    url = "https://github.com/dhavalkshah/kong-oidc.git",
    tag = "v1.1.0",
    dir = "cust-oidc"
}
description = {
    summary = "A Kong plugin for implementing the OpenID Connect Relying Party (RP) functionality",
    detailed = [[
        kong-cust-oidc is a Kong plugin for implementing the OpenID Connect Relying Party.

        When used as an OpenID Connect Relying Party it authenticates users against an OpenID Connect Provider using OpenID Connect Discovery and the Basic Client Profile (i.e. the Authorization Code flow).

        It maintains sessions for authenticated users by leveraging lua-resty-session thus offering a configurable choice between storing the session state in a client-side browser cookie or use in of the server-side storage mechanisms shared-memory|memcache|redis.

        It supports server-wide caching of resolved Discovery documents and validated Access Tokens.

        It can be used as a reverse proxy terminating OAuth/OpenID Connect in front of an origin server so that the origin server/services can be protected with the relevant standards without implementing those on the server itself.
    ]],
    homepage = "https://github.com/dhavalkshah/kong-oidc.git",
    license = "Apache 2.0"
}
dependencies = {
    "lua-resty-openidc ~> 1.6.1-1"
}
build = {
    type = "builtin",
    modules = {
    ["kong.plugins.cust-oidc.filter"] = "kong/plugins/cust-oidc/filter.lua",
    ["kong.plugins.cust-oidc.handler"] = "kong/plugins/cust-oidc/handler.lua",
    ["kong.plugins.cust-oidc.schema"] = "kong/plugins/cust-oidc/schema.lua",
    ["kong.plugins.cust-oidc.session"] = "kong/plugins/cust-oidc/session.lua",
    ["kong.plugins.cust-oidc.utils"] = "kong/plugins/cust-oidc/utils.lua"
    }
}