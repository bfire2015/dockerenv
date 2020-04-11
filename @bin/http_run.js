const {exec} = require('child_process');
const querystring = require('querystring');
const fs = require('fs');

var date = format => {
	var dateObj = () => {
		var d = new Date(), r = {};
		r.Y = d.getFullYear();
		r.m = d.getMonth() + 1;
		r.d = d.getDate();
		r.H = d.getHours();
		r.i = d.getMinutes();
		r.s = d.getSeconds();
		return r;
	};
	var d = dateObj();
	function f(k){
		var i = d[k];
		return new RegExp('m|d|H|i|s').test(k) && i < 10 ? '0' + i : i;
	}
	return (format || 'Y-m-d H:i:s').replace(new RegExp('Y|m|d|H|i|s', 'g'), f);
};

var callback = (ret, ok) => {
	var d = {ok: ok || 0, ret: ret};
	$res.writeHead(200);
	$res.end(JSON.stringify(d));
};

var log = s => {
	var dir = '/data/wwwroot/dockerenv_log/data/' + date('Ym') + '/docker_' + $name + '/';
	exec('mkdir -p ' + dir, () => {
		fs.appendFile(dir + date('Y-m-d') + '.php', "[" + date() + "]\t[" + $workid + "-" + $No + "]\t" + s + "\n", err => {
			err && console.log('日志写入失败', err);
		});
	});
};

var run = cmd => {
	log(cmd);
	exec(cmd, (err, stdout, srderr) => {
		var s = stdout + srderr;
		log(s);
		if(err){
			console.log('执行失败', $workid + '-' + $No, s);
			callback(s);
		}else{
			callback(s, 1);
		}
	});
};

var $name, $workid, $No, $req, $res;
module.exports = (name, workid, No, req, res) => {
	$name = name;
	$workid = workid;
	$No = No;
	$req = req;
	$res = res;

	var tm = setTimeout(() => {
		callback('timeout 1000');
	}, 1000);

	//接收post参数
	var postData = '';
	$req.setEncoding('utf-8');
	$req.addListener('data', postDataStream => {
		postData += postDataStream;
	});
	$req.addListener('end', () => {
		clearTimeout(tm);
		var param = querystring.parse(postData), cmd = param.cmd;
		if(cmd){
			run(cmd);
		}else{
			callback('error cmd');
		}
	});
};