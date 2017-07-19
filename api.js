const jsonServer = require('json-server');
const port = 4000;

const server = jsonServer.create();
server.use(jsonServer.defaults());

const router = jsonServer.router('db.json');
server.use(router);

console.log(`Listening at port ${port}`);
server.listen(port);