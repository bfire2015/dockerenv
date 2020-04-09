const {exec} = require('child_process');
const cluster = require('cluster');
const HOST = process.argv.HOST;
const PORT = process.argv.PORT;
if(cluster.isMaster){//主进程
	const NUM = process.argv.NUM;//子进程数量
	if(HOST && PORT && NUM){
		var No = 1;
		for(var i = 0; i < NUM; i++){
			cluster.fork();
		}
		cluster.on('message', (worker, code) => {//监听子进程消息
			if(code === 'No++'){//收到子进程的消息
				No++;
				for(var id in cluster.workers){//广播消息
					cluster.workers[id].send(No);
				}
			}else{//hb是心跳包
				//console.log('收到子进程' + worker.id + '消息', code);
			}
		});
		cluster.on('exit', (worker, code, signal) => {
			console.log(`worker ${worker.process.pid} exit`);
		});
	}else{
		console.log('Error param', process.argv);
	}
}else{//子进程
	const workid = cluster.worker.id;
	const http = require('http');
	const run = require('./http_run');
	var No = 1;
	process.on('message', (msg) => {
		No = parseInt(msg) || 0;
		//console.log('子进程' + workid + '收到消息', No);
	});
	http.createServer((req, res) => {
		process.send('No++');//向主进程发消息
		run(process.argv.NAME, workid, No, req, res);//主要运行逻辑
	}).listen(PORT, HOST);

	setInterval(() => {//将主进程发送心跳包
		process.send('hb');
	}, 60000);

	console.log('Server running on http://' + HOST + ':' + PORT + '(' + workid + ')');
}