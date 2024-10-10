require('dotenv').config();
const config = require('./config/config').cfg;
const appPort = config.server.port;
const appHost = config.server.host;
const contextPath = config.server.contextPath;

const authHandler = require('./routes/auth');

const bodyParser = require('body-parser');
const express = require("express");

const app = express();
app.set('config', config);
app.use(bodyParser.json());

app.use(contextPath, authHandler.router);

authHandler.init(app);

var server = app.listen(appPort, appHost, () => {
    console.log(`Server is running on http://${appHost}:${appPort}`);
});

function gracefulShutdown() {
    console.log('Closing the server');
    server.close();
}
process.on('SIGINT', gracefulShutdown)
process.on('SIGTERM', gracefulShutdown)
