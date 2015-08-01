var oMap;
var marker;
var polygons;

/* latlng 여러개 저장을 위한 변수 */
var k = 0

/* 다각형 꼭지점 저장을 위한 변수 */
var polygonCoords = new Array();

function loadNaverMap(lat, lng, level){
	if ( lat == 0 || lng == 0 || isNaN(lat) || isNaN(lng)){
		lat = 37.48121;
		lng = 126.952712;
	};
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

	//infoWindow
	var oInfoWnd = new nhn.api.map.InfoWindow();
	oMap.addOverlay(oInfoWnd);
	oInfoWnd.setVisible(true);
	oMap.attach('click', function(oCustomEvent) {
		var oTarget = oCustomEvent.target;
		if (oTarget instanceof nhn.api.map.Marker) {
			//if (oCustomEvent.clickCoveredMarker) {
			//	return;
			//};
			var oMarker = oTarget;
			oInfoWnd.setContent('<strong style="color: red">' + oMarker.getPoint().getY() + ',' + oMarker.getPoint().getX() + '</strong>');
			oInfoWnd.setPoint(oMarker.getPoint());
			oInfoWnd.setPosition({right : 10, top : 0});
			oInfoWnd.autoPosition();
		}
	});

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
	addRow();

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

// add input box
function addRow() {
	var row = $("#latlng_table tr:eq(2)").clone();
	var td_lat = row.find("td:eq(0)").children();
	var td_lng = row.find("td:eq(1)").children();
	
	td_lat.attr("id", "coord_lat_".concat(k+1));
	td_lng.attr("id", "coord_lng_".concat(k+1));
	td_lat.val("");
	td_lng.val("");

	$("#latlng_table").append(row);
};

function delRows() {
	var table = document.getElementById("latlng_table");
	var l = table.rows.length;
	var i;	
	
	for(i = l - 1; i > 2; i--) {
		table.deleteRow(i);
	};
};
