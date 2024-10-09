local utils = require("kong.plugins.cust-oidc.utils")

local M = {}

function M.configure(config)
    -- if config.session_name then
    --     ngx.log(ngx.NOTICE, "Session name is " .. config.session_name)
    --     if ngx.var.nginx_session then
    --         ngx.log(ngx.NOTICE, "nginx session is also present" .. ngx.var.nginx_session)
    --     else
    --         ngx.log(ngx.NOTICE, "ngixn sessions is not present")
    --         ngx.var.nginx_session = config.session_name
    --     end
    -- else
    --     ngx.log(ngx.NOTICE, "Session name is not present")
    --     ngx.var.nginx_session = "default"
    -- end
    if config.session_secret then
        ngx.log(ngx.NOTICE, "Session secret is present " .. config.session_secret)
        local decoded_session_secret = ngx.decode_base64(config.session_secret)
        if not decoded_session_secret then
            utils.exit(500, "invalid OIDC plugin configuration, session secret could not be decoded",
                ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR))
        end
        ngx.log(ngx.NOTICE, "Configured session with secret " .. decoded_session_secret)
        ngx.var.session_secret = decoded_session_secret
    else
        ngx.log(ngx.NOTICE, "No session secret ")
    end
end

return M
