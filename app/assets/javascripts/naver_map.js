var oMap;
var marker;
var polygons;

/* latlng 여러개 저장을 위한 변수 */
var k = 0

/* 다각형 꼭지점 저장을 위한 변수 */ 
var polygonCoords = [];


/***** Map *****/
// Info means if this map needs infoWindow(true) or labels(false).
function loadNaverMap(level, info){
	var defaultPoint = new nhn.api.map.LatLng(37.48121, 126.952712);
	var defaultLevel = level || 10;

	// Set map's width and heigth.
	var deviceWidth = responsiveMapWidth();
	var mapHeight = deviceWidth * 0.618;

	oMap = new nhn.api.map.Map(document.getElementById('naver_map'), { 
																	point : defaultPoint,
																	zoom : defaultLevel,
																	enableDragPan : true,  
																	enableWheelZoom : true,
																	enableDblClickZoom : true,
																	mapMode : 0,
																	size : new nhn.api.map.Size(deviceWidth, mapHeight),
																	minMaxLevel : [ 1, 14 ]
														});

	oMap.attach("contextmenu", drawPolygon);
	mapAndMarkers(info);
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


/***** Marker *****/

// Default Naver map icon
var defaultNaverOffset = new nhn.api.map.Size(14, 37);
var defaultNaverSize = new nhn.api.map.Size(28, 37);
var defaultNaverIcon = new nhn.api.map.Icon("/images/mymaps/naver_map_icon.png", defaultNaverSize, defaultNaverOffset);

// Default group icon
var defaultGroupOffset = new nhn.api.map.Size(28, 28);
var defaultGroupSize = new nhn.api.map.Size(18, 18);
var defaultGroupIcon = new nhn.api.map.Icon("/images/mymaps/mymap_group_icon_default.svg", defaultGroupSize, defaultGroupOffset);


// Show MyMap's group markers and set center of those markers.
function mapAndMarkers(info) {
	if ( window.location.href.match(/.*\/restaurants\?/) ) {
		var jsonUrl = window.location.href.replace('/restaurants?', '/restaurants.json?');
	} else {
		var jsonUrl = window.location.href + '.json';
	}

	$.getJSON( jsonUrl )
		.done( function(data) {
			displayMarkers(data);
			setMapCenter(data);
			setMapLevel(data);

			// If info is true, infoWindows will appear on the map.
			// If not, labels will do.
			if ( info ) {
				loadInfoWindow(data);
			} else {
				toggleLabels();
			};
	});
}

// Attach group icon markers to map.
function displayMarkers(data) {
	$.each( data.restaurants, function( index, restaurant ) {
		if ( restaurant.mymap.group > 0 ) {
			oOffset = new nhn.api.map.Size(28, 28);
			oSize = new nhn.api.map.Size(28, 28);
			oIcon = new nhn.api.map.Icon(groupIconPath(restaurant.mymap.group), oSize, oOffset);
		} else if ( restaurant.mymap.group == 0 ) {
			oIcon = defaultGroupIcon;
		} else {
			oIcon = defaultNaverIcon;
		};

		var oLatLng = new nhn.api.map.LatLng(restaurant.lat, restaurant.lng);
		var marker = new nhn.api.map.Marker(oIcon, { 
																					point: oLatLng,
																					zIndex: index,
																					title: restaurant.name
																			 });

		oMap.addOverlay(marker);
	});
}

function groupIconPath(n) {
	return '/images/mymaps/mymap_group_icon_' + n + '.svg'
}

// Get json data of mymap and set center of the map.
function setMapCenter(data) {
	var div = 0, lat_sum = 0, lng_sum = 0;
	var snu_lat = 37.48121, snu_lng = 126.952712;

	$.each( data.restaurants, function( i, restaurant ) {
		div += 1;
		lat_sum += parseFloat(restaurant.lat);
		lng_sum += parseFloat(restaurant.lng);
	});

	lat = lat_sum/div || snu_lat;
	lng = lng_sum/div || snu_lng;

	var centerLatLng = new nhn.api.map.LatLng(lat, lng)
	oMap.setCenter(centerLatLng);
}

// Get json data of mymap and set level for the map.
function setMapLevel(data) {
	var lat_max = 0, lat_min = 1000, lng_max = 0, lng_min = 1000;
	var lat_range = 0, lng_range = 0, level;

	$.each( data.restaurants, function( i, restaurant ) {
		lat_max = Math.max(lat_max, restaurant.lat);
		lat_min = Math.min(lat_min, restaurant.lat);
		lng_max = Math.max(lng_max, restaurant.lng);
		lng_min = Math.min(lng_min, restaurant.lng);
	});

	lat_range = lat_max - lat_min;
	lng_range = lng_max - lng_min;

	if ( lat_range > 0.28 || lng_range > 0.18 ) {
		level = 5;
	} else if ( lat_range > 0.15  || lng_range > 0.09  ) {
	  level = 6;
	} else if ( lat_range > 0.075 || lng_range > 0.04  ) {
	  level = 7;
	} else if ( lat_range > 0.035 || lng_range > 0.02  ) {
	  level = 8;
	} else if ( lat_range > 0.02  || lng_range > 0.013 ) {
	  level = 9;
	} else if ( lat_range > 0.01  || lng_range > 0.005 ) {
	  level = 10;
	} else {
	  level = 11;
	};
	
	oMap.setLevel(level);
}


/***** Label *****/
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


/***** InfoWindow *****/

// Load infoWindow.
function loadInfoWindow(data) {

	// Create infoWindow.
	var infoWindow = new nhn.api.map.InfoWindow();
	infoWindow.setVisible(false);
	oMap.addOverlay(infoWindow);
	
	// Create Label.
	var markerLabel = new nhn.api.map.MarkerLabel();
	oMap.addOverlay(markerLabel);

	// Avoid label and infoWindow's collision.
	infoWindow.attach('changeVisible', function(e) {
		if ( e.visible ) {
			markerLabel.setVisible(false);
		}
	});

	// Show marker's label with mouse.
	oMap.attach('mouseenter', function(e) {
		var target = e.target;
		if ( target instanceof nhn.api.map.Marker ) {
			var marker = target;
			markerLabel.setVisible(true, marker);
		}
	});

	oMap.attach('mouseleave', function(e) {
		var target = e.target;
		if ( target instanceof nhn.api.map.Marker ) {
			markerLabel.setVisible(false);
		}
	});

	// Show infoWindow on mouseclick.
	oMap.attach('click', function(e) {
		var point = e.point;
		var target = e.target;
		infoWindow.setVisible(false);

		// When click marker.
		if ( target instanceof nhn.api.map.Marker ) {

			// When click the same marker.
			if ( e.clickCoveredMarker ) { return; }
			
			var index = target.getZIndex();
			infoWindow.setContent("<div id='info_window_" + data.restaurants[index].id + "'></div>");
			// Ajax
			infoWindowContents(index, data);

			infoWindow.setPoint(point);
			infoWindow.setVisible(true);
			infoWindow.setPosition({ right: 15, top: 30 });
			infoWindow.autoPosition();
			return;
		}
	});
}

// Ajax call for infoWindow's contents
function infoWindowContents(index, data) {
	var restaurant = data.restaurants[index];
	var mymap = data.restaurants[index].mymap;

	$.ajax({
		type: 'GET',
		url: '/home/info_window',
		data: {
			id: 				restaurant.id,
			mymap_id: 	mymap.id
		}
	});
}




/*********************************************/


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
