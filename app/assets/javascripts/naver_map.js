var oMap;
/*
var marker;
var polygons;
*/
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
	/*
	oMap.attach("click", Setmarker);
	oMap.attach("contextmenu", draw_polygon);
	*/
};

/*
function Setmarker(event) {
	var oSize = new nhn.api.map.Size(28, 37);
		var oOffset = new nhn.api.map.Size(14, 37);
		var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
	marker = new nhn.api.map.Marker(oIcon, {title : '마커'});
	marker.setPoint(event.point);
	oMap.addOverlay(marker);

	polygonCoords.push(event.point);

	var lats = document.getElementsByClassName("lat");
	var lngs = document.getElementsByClassName("lng");
	
	lats[k].value = event.point.getY();
	lngs[k].value = event.point.getX();

	k += 1;
};

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
