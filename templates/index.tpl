{include file='header.tpl'}

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
	  
        <h1>Tomacar</h1>
        <p>Welcome to <b>Tomacar</b>. The easy way to drive and park around Southampton.</p>
        <p>
          <a class="btn btn-lg btn-primary" href="/about" role="button">About us &raquo;</a>
        </p>
      </div>
	  <div class="row">
		<div class="col-md-8">
			<div class="jumbotron" id="map"></div>
		</div>
		<div class="col-md-4">
			<div id="locations" class="jumbotron">
				<p><b>Loading...</b>
				{foreach from=$stations key=count item=count}
					<tr>
						<td><a href="/journeys/start?start={$count}"><img src="/images/carbutton.jpg"></a></td>
					</tr>
				{/foreach}
				</p>
				
			</div>
		</div>
	  </div>
    </div> <!-- /container -->
	{literal}
    <script>
      function initMap() {

      	var styles = [];

      	{/literal}{if $injourney}{literal}
      		styles = [
            {elementType: 'geometry', stylers: [{color: '#242f3e'}]},
            {elementType: 'labels.text.stroke', stylers: [{color: '#242f3e'}]},
            {elementType: 'labels.text.fill', stylers: [{color: '#746855'}]},
            {
              featureType: 'administrative.locality',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'poi',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'poi.park',
              elementType: 'geometry',
              stylers: [{color: '#263c3f'}]
            },
            {
              featureType: 'poi.park',
              elementType: 'labels.text.fill',
              stylers: [{color: '#6b9a76'}]
            },
            {
              featureType: 'road',
              elementType: 'geometry',
              stylers: [{color: '#38414e'}]
            },
            {
              featureType: 'road',
              elementType: 'geometry.stroke',
              stylers: [{color: '#212a37'}]
            },
            {
              featureType: 'road',
              elementType: 'labels.text.fill',
              stylers: [{color: '#9ca5b3'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'geometry',
              stylers: [{color: '#746855'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'geometry.stroke',
              stylers: [{color: '#1f2835'}]
            },
            {
              featureType: 'road.highway',
              elementType: 'labels.text.fill',
              stylers: [{color: '#f3d19c'}]
            },
            {
              featureType: 'transit',
              elementType: 'geometry',
              stylers: [{color: '#2f3948'}]
            },
            {
              featureType: 'transit.station',
              elementType: 'labels.text.fill',
              stylers: [{color: '#d59563'}]
            },
            {
              featureType: 'water',
              elementType: 'geometry',
              stylers: [{color: '#17263c'}]
            },
            {
              featureType: 'water',
              elementType: 'labels.text.fill',
              stylers: [{color: '#515c6d'}]
            },
            {
              featureType: 'water',
              elementType: 'labels.text.stroke',
              stylers: [{color: '#17263c'}]
            }
          ];
      	{/literal}{/if}{literal}

        $.ajax({ 
			type: 'GET', 
			url: '/ajax/stations', 
			data: { get_param: 'value' }, 
			dataType: 'json',
			success: function (data) { 
				var markers = [];
				// Create an array of alphabetical characters used to label the markers.
				var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
				
				//Initialise the map
				var map = new google.maps.Map(document.getElementById('map'), {
				  zoom: 13,
				  styles: styles
				});
				
				// Center on the users location
				if (navigator.geolocation) {
					 navigator.geolocation.getCurrentPosition(function (position) {
						 initialLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
						 map.setCenter(initialLocation);
						});
					} else {
						map.setCenter( new google.maps.LatLng(50.935807, -1.396226) );
					}
				
				map.addListener('zoom_changed', function() {
					zoomLevel = map.getZoom();
					if(zoomLevel < 13) {
						document.getElementById("locations").innerHTML = text;
					}
				});
				
				var text = "<p><b>Stations</b></p>";
				
				$.each(data, function(i, element) {
					var label = labels[i - 1 % labels.length];
					
					text += "<div><b>" + label + "</b> " + element.name + "<br /><b>" + element.count + "/" + element.capacity + "</b></div>";
					var marker = new google.maps.Marker({
					  position: {lat: parseFloat(element.lat), lng: parseFloat(element.lng)},
					  label: label,
					  name: element.name,
					  capacity: element.capacity,
					  count: element.count,
					  id: i,
					  map: map,
					  title: 'Click to zoom'
					});
					
					marker.addListener('click', function() {
					  map.setZoom(15);
					  map.setCenter(marker.getPosition());
					  
					  var button = '';

					  if(marker.count > 0) {
					  	button = '<a href="/journeys/start?start=' + marker.id + '" class="btn btn-primary">Start Journey</a>';
					  } else {
					  	button = '<b>Sorry no cars here</b>';
					  }

					  document.getElementById("locations").innerHTML = `
					  	<p>
					<b><u>` + marker.name + `</u></b>
					<br />
					Capacity: ` + marker.count + `/` + marker.capacity + `
					<br />
					` + button + `
					  `;
					});
					
					markers.push(marker);
				});
				
				document.getElementById("locations").innerHTML = text;
				 var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
				
				
			}
		});
	}
    </script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_Zm-kRbAHsa3293Oycz6gO1GxYTq-9q4&callback=initMap">
    </script>
	{/literal}

{include file='footer.tpl'}