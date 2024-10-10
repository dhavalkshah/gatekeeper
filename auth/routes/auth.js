const { default: axios } = require('axios');
const qs = require('qs');
var express = require('express');
var _ = require('underscore')._;
var router = express.Router();
var appCtx;

function init(appCtx) {
    module.exports.appCtx = appCtx;
}

router.get('/callback', function(req, res){
    let appCtx = module.exports.appCtx;
    console.log(req.query);
    let cfg = appCtx.get('config');
    axios.post(
        `${cfg.keycloak.authServerUrl}/realms/${cfg.keycloak.realm}/protocol/openid-connect/token`,
        `grant_type=authorization_code&client_id=${cfg.keycloak.clientId}&client_secret=${cfg.keycloak.credentials.secret}&code=${req.query.code}&redirect_uri=${cfg.keycloak.redirectUri}`
    )
    .then((resp)=>{
        console.log(resp);
        res.status(200).send({
            args: req.query,
            data: req.body,
            headers: req.headers,
            method: req.method,
            origin: req.origin,
            url: req.originalUrl,
            authresp: resp.data
        });
    })
    
});

router.post('/login/:clientId', function(req, res){
    let appCtx = module.exports.appCtx;
    let username = req.body.username;
    let password = req.body.password;
    let clientId = req.params.clientId;
    let cfg = appCtx.get('config');
    console.log(req.body, clientId, cfg.keycloak.clients[clientId].secret)

    let data = qs.stringify({
        'username': username,
        'password': password,
        'grant_type': 'password',
        'client_id': clientId,
        'client_secret': cfg.keycloak.clients[clientId].secret,
        'scope': 'openid' 
    });

    let config = {
        method: 'post',
        maxBodyLength: Infinity,
        url: cfg.keycloak.authServerUrl+'realms/'+cfg.keycloak.realm+'/protocol/openid-connect/token',
        headers: { 
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        data : data
    };

    axios.request(config)
    .then((resp)=>{
        // console.log('Response from token api is', JSON.stringify(resp.data));
        res.status(200).send(JSON.stringify(resp.data));
    })
    .catch((err)=>{
        // console.log('Failed to login using username & password', err);
        res.status(400).send(err);
    });
});

module.exports = {
    router: router,
    init: init,
    appCtx: appCtx,
};

