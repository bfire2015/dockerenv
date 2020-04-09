const HOST = '0.0.0.0';
const PORT = 8888;
const {exec} = require('child_process');
var par = process.argv[2];
if(par === 'stop' || par === 'ps'){
	var sh = 'ps -ef | grep http.js | grep -v grep | awk \'{print "kill -9 "$2}\'';
	par === 'stop' && (sh += '|sh');
	exec(sh, (err, stdout, srderr) => {
		console.log(err ? '[err]' : '[ok]', stdout, srderr);
	});
}else{
	process.argv.HOST = HOST;
	process.argv.PORT = PORT;
	process.argv.NAME = par;
	process.argv.NUM = Math.max(parseInt(process.argv[3]) || 1, 1);
	var No = 0;
	if(process.argv.NUM > 1){//多进程
		require('./http_more');
	}else{//单进程
		require('./http_one');
	}
}