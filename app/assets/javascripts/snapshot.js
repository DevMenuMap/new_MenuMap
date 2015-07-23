var page = require('webpage').create();
var target = 'http://52.69.51.63/users/' + phantom.args[3] + '/mymap_snapshot/?' + 'lat=' + phantom.args[0] + '&' + 'lng=' + phantom.args[1] + '&' + 'level=' + phantom.args[2];
var file_name = './public/images/' + phantom.args[3] + '.png';
page.viewportSize = {width: 3200, height: 1800 };
page.clipRect = { top: 440, left: 8, width:1000, height: 704 }; 

page.open(target, function() {
  page.render(file_name);
  phantom.exit();
});
