//import http package through node.js
const http = require('http');
//import the app that we just created
const app = require('./app');
//assign a port to our localhosted server
const port = process.env.PORT || 3000;
//create a server and pass it a listener (the app)
const server = http.createServer(app);
//start listening on our port
server.listen(port);
