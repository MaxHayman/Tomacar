{include file='header.tpl'}

	<br><h2>Your Journeys</h2><br>
	  <table class="table table-striped">
		<thead>
		  <tr>
			<th>Id</th>
			<th>Car No.</th>
			<th>From</th>
			<th>To</th>
			<th>Start</th>
			<th>End</th>
			<th>Duration</th>
			<th>Cost</th>
		  </tr>
		</thead>
		<tbody>
		  <tr>
			<td>{$journey.journeyId}</td>
			<td>{$journey.journeyCar}</td>
			<td>{$journey.startName}</td>
			<td>{$journey.endName}</td>
			<td>{$journey.start|date_format:"%c"}</td>
			<td>{$journey.end|date_format:"%c"}</td>
			<td>{$journey.duration}</td>
			<td></td>
		  </tr>
		</tbody>
	  </table>

	  <div class="jumbotron" id="map"></div>
	  
	  	{literal}
    <script>
      function initMap() {

				var markers = [];
				
				var map = new google.maps.Map(document.getElementById('map'), {
				  zoom: 13,
				  center: {lat: 50.935807, lng: -1.396226} 
				}), directionsService = new google.maps.DirectionsService,
				directionsDisplay = new google.maps.DirectionsRenderer({
				  map: map
				});
				
				map.addListener('zoom_changed', function() {
					zoomLevel = map.getZoom();
					if(zoomLevel < 13) {
						document.getElementById("locations").innerHTML = text;
					}
				});
				
		
					var marker1 = new google.maps.Marker({
					  position: {{/literal}lat: parseFloat({$journey.fromLat}), lng: parseFloat({$journey.fromLng}){literal}},
					  label: "Start",
					  map: map,
					  title: 'Click to zoom'
					});
					
					var marker2 = new google.maps.Marker({
					  position: {{/literal}lat: parseFloat({$journey.toLat}), lng: parseFloat({$journey.toLng}){literal}},
					  label: "End",
					  map: map,
					  title: 'Click to zoom'
					});
					{/literal}
					map.setCenter(new google.maps.LatLng(({$journey.fromLat}+{$journey.toLat})/2,({$journey.fromLng}+{$journey.toLng})/2));
					{literal}
					/*calculateAndDisplayRoute(directionsService, directionsDisplay, marker1, marker2);*/
					
					marker.addListener('click', function() {
					  map.setZoom(15);
					  map.setCenter(marker.getPosition());
					});
					
					markers.push(marker);
				
				document.getElementById("locations").innerHTML = text;
				 var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});

	}
    </script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_Zm-kRbAHsa3293Oycz6gO1GxYTq-9q4&callback=initMap">
    </script>
	{/literal}
  
{include file='footer.tpl'}