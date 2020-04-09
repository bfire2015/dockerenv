const http = require('http');
const run = require('./http_run');
const HOST = process.argv.HOST;
const PORT = process.argv.PORT;
if(HOST && PORT){
	var No = 0;
	http.createServer((req, res) => {
		run(process.argv.NAME, 0, ++No, req, res);
	}).listen(PORT, HOST);
	console.log('Server running on http://' + HOST + ':' + PORT);
}else{
	console.log('Error param', process.argv);
}
