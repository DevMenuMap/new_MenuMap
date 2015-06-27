var oMap;
var marker;
var polygons;

/* latlng 여러개 저장을 위한 변수 */
var k = 0

/* 다각형 꼭지점 저장을 위한 변수 */
var polygonCoords = new Array();

function loadNaverMap(){
	var oSeoulNatlSubway = new nhn.api.map.LatLng(37.48121, 126.952712);
	oMap = new nhn.api.map.Map(document.getElementById('naver_map'), { 
																	point : oSeoulNatlSubway,
																	zoom : 10,
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
	oMap.attach("contextmenu", drawPolygon);
};

// Show marker on mouse click
function setMarker(event) {
	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon("https://s3-ap-southeast-1.amazonaws.com/menumap-s3-development/static_assets/images/naver_map_icon.png", oSize, oOffset);
	
	var oLatLng = event.point
	marker = new nhn.api.map.Marker(oIcon, {title : "marker"});
	marker.setPoint(oLatLng);
	oMap.addOverlay(marker);

	// Put latitude and longitude on input
	var latString = "addr_rule_lat_";
	var lngString = "addr_rule_lng_";
	document.getElementById(latString.concat(k)).value = oLatLng.getY();
	document.getElementById(lngString.concat(k)).value = oLatLng.getX();
	k += 1;

	// Put latlng to polygonCoords array
	polygonCoords.push(oLatLng);
};

// Draw polygon when right-click
function drawPolygon(event){
	polygons = new nhn.api.map.Polygon(polygonCoords, {
		strokeColor: "blue",
		strokeOpacity: 1,
		strokeWidth: 2,
		fillColor: "lightblue",
		fillOpacity: 0.5
	});

	oMap.addOverlay(polygons);
};
