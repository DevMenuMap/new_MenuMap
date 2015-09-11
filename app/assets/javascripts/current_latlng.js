function geoFindMe() {
	if (!navigator.geolocation) {
		alert("위치정보를 이용할 수 없는 상태입니다.");
		return;
	};

	function success(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		document.getElementById("curr_lat").value = lat;
		document.getElementById("curr_lng").value = lng;
		document.getElementById("submitbutton").value = "gogogo";
	};
	
	function error() {
		alert("사용자의 위치를 찾을 수 없습니다.");
		document.getElementById("submitbutton").value = "gogogo";
	};

	document.getElementById("submitbutton").value = "Locating...";
	navigator.geolocation.getCurrentPosition(success, error);
};
