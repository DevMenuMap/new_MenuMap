var page = require('webpage').create();

var target = 'http://menumap.co.kr/users/' + phantom.args[0] + '/mymap_snapshot';
var file_name = './public/images/mymap_snapshots/' + phantom.args[0] + '_mymap_snapshot.png';

page.viewportSize = { width: 1000, height: 740 };
page.clipRect = { top: 52, left: 0, width: 970, height: 599 }; 

page.open(target, function(status) {
	console.log(status);	
	window.setTimeout(function() {
		page.render(file_name);
		phantom.exit();
	}, 500);
	console.log('finished');
});
