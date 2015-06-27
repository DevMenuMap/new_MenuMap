var oMap;
var marker;
// var polygons;

/* latlng여러개 저장을 위한 변수 */
// var k = 0
/* 다각형 꼭지점 저장을 위한 변수 */
// var polygonCoords = new Array();

function initialize(){
	var oSeoulNatlSubway = new nhn.api.map.LatLng(37.48121, 126.952712);
	oMap = new nhn.api.map.Map(document.getElementById('naver_map'), { 
																	point : oSeoulNatlSubway,
																	zoom : 11,
																	// move on map with mouse dragging
																	enableDragPan : true,  
																	enableWheelZoom : true,
																	enableDblClickZoom : true,
																	mapMode : 0,
																	// activateTrafficMap : false,
																	// activateBicycleMap : false,
																	size : new nhn.api.map.Size(1000, 700),
																	minMaxLevel : [ 1, 14 ]
														});

	oMap.attach("click", setMarker);
	// oMap.attach("contextmenu", draw_polygon);
};

// Show marker on mouse click
function setMarker(event) {
	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon("https://s3-ap-southeast-1.amazonaws.com/menumap-s3-development/static_assets/images/naver_map_icon.png", oSize, oOffset);

	marker = new nhn.api.map.Marker(oIcon, {title : "marker"});
	marker.setPoint(event.point);
	oMap.addOverlay(marker);

	var lat = document.getElementById("addr_rule_01_lat");
	var lng = document.getElementById("addr_rule_01_lng");

	lat.value = event.point.getY();
	lng.value = event.point.getX();

	// polygonCoords.push(event.point);
	
	/*
	lats[k].value = event.point.getY();
	lngs[k].value = event.point.getX();

	k += 1;
	*/
};

/*
function draw_polygon(event){
	polygons = new nhn.api.map.Polygon(polygonCoords, {
		strokeColor: "blue",
		strokeOpacity: 1,
		strokeWidth: 2,
		fillColor: "lightblue",
		fillOpacity: 0.5
	});
	oMap.addOverlay(polygons);
};
*/
