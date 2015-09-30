var oMap;
var marker;
var polygons;

/* latlng 여러개 저장을 위한 변수 */
var k = 0

/* 다각형 꼭지점 저장을 위한 변수 */
var polygonCoords = [];

// Default group icon
var defaultGroupIconOffset = new nhn.api.map.Size(28, 28);
var defaultGroupIconSize = new nhn.api.map.Size(18, 18);
var defaultGroupIcon = new nhn.api.map.Icon("/images/mymaps/mymap_group_icon_default.svg", defaultGroupIconSize, defaultGroupIconOffset);


function loadNaverMap(level){
	// var defaultPoint = new nhn.api.map.LatLng(37.48121, 126.952712);
	var defaultPoint = new nhn.api.map.LatLng(37.4832357, 126.9288968);
	// var defaultLevel = level || 10;
	var defaultLevel = level || 12;

	// Set map's width and heigth.
	var deviceWidth = responsiveMapWidth();
	var mapHeight = deviceWidth * 0.618;

	oMap = new nhn.api.map.Map(document.getElementById('naver_map'), { 
																	point : defaultPoint,
																	zoom : defaultLevel,
																	// move on map with mouse dragging
																	enableDragPan : true,  
																	enableWheelZoom : true,
																	enableDblClickZoom : true,
																	mapMode : 0,
																	// activateTrafficMap : false,
																	// activateBicycleMap : false,
																	size : new nhn.api.map.Size(deviceWidth, mapHeight),
																	minMaxLevel : [ 1, 14 ]
														});

	oMap.attach("contextmenu", drawPolygon);
};

// Return responsive width of naver map for devices.
function responsiveMapWidth() {
	var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;

	if (width > 1200) {
		width = 585;
	} else if (width > 992) {
		width = 970;
	} else if (width > 768) {
		width = 750;
	}

	return width;
}

// Show MyMap's group markers.
function showMymapMarkers() {
	var jsonUrl = window.location.href + '.json'

	$.getJSON( jsonUrl )
		.done( function(data) {
			$.each( data.mymaps, function( i, mymap ) {
				console.log( mymap.name );
				mymapGroupMarkers( mymap.lat, mymap.lng, mymap.mymapGroup );
			});
	});
}

// Attach group icon markers to map.
function mymapGroupMarkers(lat, lng, group) {
	var oOffset, oSize, oIcon;

	if ( group > 0 ) {
		oOffset = new nhn.api.map.Size(28, 28);
		oSize = new nhn.api.map.Size(28, 28);
		oIcon = new nhn.api.map.Icon(groupIconPath(group), oSize, oOffset);
	} else {
		oIcon = defaultGroupIcon;
	};

	var oLatLng = new nhn.api.map.LatLng(lat, lng);
	var marker = new nhn.api.map.Marker(oIcon, { point: oLatLng });
	oMap.addOverlay(marker);
}

function groupIconPath(n) {
	return '/images/mymaps/mymap_group_icon_' + n + '.svg'
}

// showLabels -> toggleLabels 20150810
function toggleLabels() {
	var oLabel = new nhn.api.map.MarkerLabel();
	var oMarker_new;
	var oMarker_old;
	oMap.addOverlay(oLabel);
	oMap.attach('click', function(oCustomEvent) {
		if (oCustomEvent.target instanceof nhn.api.map.Marker) {
			oMarker_old = oMarker_new;
			oMarker_new = oCustomEvent.target;

			if (oMarker_new == oMarker_old) {
				oLabel.setVisible(false, oMarker_new);
				oMarker_new = undefined;
			} else {
				oLabel.setVisible(true, oMarker_new);
			};
		};

		if (oCustomEvent.target instanceof nhn.api.map.Map) {
			oLabel.setVisible(false, oMarker_new);
			oMarker_new = undefined;
		};
	});
};

// Set marker on mouse click ( new_addr_rule )
function setMarker(event) {
	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon("/images/mymaps/naver_map_icon.png", oSize, oOffset);
	
	var oLatLng = event.point
	marker = new nhn.api.map.Marker(oIcon, {title : "title"});
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
function showMarkers(coordArray, noPolygon, names){
	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon("/images/mymaps/naver_map_icon.png", oSize, oOffset);
	var oLatLng;
	var showPolygon = []; 
	var i;
	var l = coordArray.length / 2;

	if ( typeof names == "undefined" ){
		names = [];
	};

	// Change this to normal data passing codes to js
	for(i = 0; i < l; i++){
		oLatLng = new nhn.api.map.LatLng(coordArray[2*i], coordArray[2*i+1]);
		marker = new nhn.api.map.Marker(oIcon, {point: oLatLng, title: names[i]});
		oMap.addOverlay(marker);
		showPolygon.push(oLatLng);
	};

	if ( noPolygon != true ) {
		polygons = new nhn.api.map.Polygon(showPolygon, {
			strokeColor: "blue",
			strokeOpacity: 1,
			strokeWidth: 2,
			fillColor: "lightblue",
			fillOpacity: 0.5
		});
		oMap.addOverlay(polygons);
	};
};

// For new addr_rule page
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

// For mymap page 
function showGroupImage(groups, coords) {
	var i;
	var l = groups.length;
	for (i = 0; i < l; i++) {
		var infoWindow = new nhn.api.map.InfoWindow();
		var	oPoint = new nhn.api.map.LatLng(coords[2 * i], coords[2 * i + 1]);
		infoWindow.setPoint(oPoint);
		infoWindow.setPosition({right : 15, top : 30});
		infoWindow.autoPosition();
		infoWindow.setVisible(true);
		infoWindow.setContent('<img style="height: 20px" src="/images/mymaps/mymap_group_icon_' + 	groups[i] + '.png">');
		oMap.addOverlay(infoWindow);
	};
};

function showGroupMarkers(coordArray, groups, names) {
	var oOffset = new nhn.api.map.Size(28, 28);
	var oSize;
	var oLatLng;
	var oIcon;
	var showPolygon = [];
	var i;
	var l = groups.length;
	for (i = 0; i < l; i++) {
		if (groups[i] != 0) {
			oSize = new nhn.api.map.Size(28, 28);
			oIcon = new nhn.api.map.Icon("/images/mymaps/mymap_group_icon_" + groups[i] + ".svg", oSize, oOffset);
		} else {
			oSize = new nhn.api.map.Size(18, 18);
			oIcon = new nhn.api.map.Icon("/images/mymaps/mymap_group_icon_default.svg", oSize, oOffset);
		};
		// Change this to normal data passing codes to js
		oLatLng = new nhn.api.map.LatLng(coordArray[2*i], coordArray[2*i+1]);
		marker = new nhn.api.map.Marker(oIcon, {point: oLatLng, title: names[i] });
		oMap.addOverlay(marker);
		showPolygon.push(oLatLng);
	};
};
