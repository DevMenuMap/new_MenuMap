var oMap;
var marker;
var polygons;

/* latlng 여러개 저장을 위한 변수 */
var k = 0

/* 다각형 꼭지점 저장을 위한 변수 */
var polygonCoords = new Array();

function loadNaverMap(lat, lng, level){
	if(typeof lat == 'undefined')
		lat = 37.48121;
	if(typeof lng == 'undefined')
		lng = 126.952712;
	if(typeof level == 'undefined')
		level = 10
	var oCenter = new nhn.api.map.LatLng(lat, lng);
	oMap = new nhn.api.map.Map(document.getElementById('naver_map'), { 
																	point : oCenter,
																	zoom : level,
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
	var latString = "coord_lat_";
	var lngString = "coord_lng_";
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

// Show markers when there are created points e.g. addresses#show
function showMarkers(coordArray){
	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon("https://s3-ap-southeast-1.amazonaws.com/menumap-s3-development/static_assets/images/naver_map_icon.png", oSize, oOffset);
	
	var oLatLng;
	var showPolygon = new Array();

	// Change this to normal data passing codes to js
	for(var i=0; i < coordArray.length; i = i + 2){
		oLatLng = new nhn.api.map.LatLng(coordArray[i], coordArray[i+1]);

		marker = new nhn.api.map.Marker(oIcon, {title : "marker"});
		marker.setPoint(oLatLng);
		oMap.addOverlay(marker);

		showPolygon.push(oLatLng);
	};

	polygons = new nhn.api.map.Polygon(showPolygon, {
		strokeColor: "blue",
		strokeOpacity: 1,
		strokeWidth: 2,
		fillColor: "lightblue",
		fillOpacity: 0.5
	});

	oMap.addOverlay(polygons);
};
