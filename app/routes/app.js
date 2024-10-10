const { default: axios } = require('axios');
const qs = require('qs');
var express = require('express');
var _ = require('underscore')._;
var router = express.Router();
var appCtx;

function init(appCtx) {
    module.exports.appCtx = appCtx;
}

router.post('/getCustomerData', function(req, res){
    console.log('Got the req body as', req.body);
    console.log('Got headers as', req.headers);
    res.status(200).send({
        'message':'received the request successfully'
    });
});

module.exports = {
    router: router,
    init: init,
    appCtx: appCtx,
};