var page = require('webpage').create();
page.clipRect = { top: 300, left: 0, width: 1024, height: 300 };
page.open('http://52.69.51.63:3000/home/show', function() {
  page.render('./public/images/1.png');
  phantom.exit();
});
