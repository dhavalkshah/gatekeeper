local CustOidcHandler = {
    PRIORITY = 1000,
    VERSION = "0.0.1"
}
local utils = require("kong.plugins.cust-oidc.utils")
local filter = require("kong.plugins.cust-oidc.filter")
local session = require("kong.plugins.cust-oidc.session")

-- function CustOidcHandler:response(conf)
--     kong.response.set_header(conf.response_header_name, "response")
--     -- kong.response.set_header("X-MyPlugin", "response")
-- end

function CustOidcHandler:access(config)
    local oidcConfig = utils.get_options(config, ngx)
    -- if(oidcConfig.client_id == "dhaval") then
    --     kong.response.set_header("X-client-id","shah")
    -- else
    --     kong.response.set_header("X-client-id","foutane")        
    -- end
    if filter.shouldProcessRequest(oidcConfig) then
        session.configure(config)
        handle(oidcConfig)
    else
        ngx.log(ngx.NOTICE, "OidcHandler ignoring request, path: " .. ngx.var.request_uri)
    end

    ngx.log(ngx.NOTICE, "OidcHandler done")
end

function handle(oidcConfig)
    local response
    if oidcConfig.introspection_endpoint then
        response = introspect(oidcConfig)
        if response then
            utils.injectUser(response)
        end
    end

    if response == nil then
        response = make_oidc(oidcConfig)
        if response then
            if (response.user) then
                utils.injectUser(response.user)
            end
            if (response.access_token) then
                utils.injectAccessToken(response.access_token)
            end
            if (response.id_token) then
                utils.injectIDToken(response.id_token)
            end
        end
    end
end

function introspect(oidcConfig)
    if utils.has_bearer_access_token() or oidcConfig.bearer_only == "yes" then
        local res, err = require("resty.openidc").introspect(oidcConfig)
        if err then
            if oidcConfig.bearer_only == "yes" then
                ngx.header["WWW-Authenticate"] = 'Bearer realm="' .. oidcConfig.realm .. '",error="' .. err .. '"'
                utils.exit(ngx.HTTP_UNAUTHORIZED, err, ngx.HTTP_UNAUTHORIZED)
            end
            return nil
        end
        ngx.log(ngx.NOTICE, "OidcHandler introspect succeeded, requested path: " .. ngx.var.request_uri)
        return res
    end
    return nil
end

function make_oidc(oidcConfig)
    ngx.log(ngx.NOTICE, "OidcHandler calling authenticate, requested path: " .. ngx.var.request_uri)
    -- local session, err, ret = require("resty.session").open(nil)
    -- if (session ~= nil) then
    --     ngx.log(ngx.NOTICE,"session is not nil")
    --     ngx.log(ngx.DEBUG,
    --         "session.present=", session.present,
    --         ", session.data.id_token=", session.data.id_token ~= nil,
    --         ", session.data.authenticated=", session.data.authenticated,
    --         ", err=", err,
    --         ", ret=",ret
    --     )
    --     session:start()
    -- else
    --     ngx.log(ngx.NOTICE, "Session is nil")
    -- end
    local res, err = require("resty.openidc").authenticate(oidcConfig)
    if err then
        if oidcConfig.recovery_page_path then
            ngx.log(ngx.NOTICE, "Entering recovery page: " .. oidcConfig.recovery_page_path)
            ngx.redirect(oidcConfig.recovery_page_path)
        end
        utils.exit(500, err, ngx.HTTP_INTERNAL_SERVER_ERROR)
    end
    return res
end

return CustOidcHandler
