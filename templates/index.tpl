{include file='header.tpl'}

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
	  
        <h1>Tomacar</h1>
        <p>Welcome to <b>Tomacar</b>. The easy way to drive and park around Southampton.</p>
        <p>
          <a class="btn btn-lg btn-primary" href="../../components/#navbar" role="button">View navbar docs &raquo;</a>
        </p>
      </div>
	  <div class="row">
		<div class="col-md-8">
			<div class="jumbotron" id="map"></div>
		</div>
		<div class="col-md-4">
			<div class="jumbotron">
				<p>
					<b><u>Highfield Campus</u></b>
					<br />
					Spaces: Avaliable
					<br />
					Cars: Avliable
					<br />
					
				</p>
				
			</div>
		</div>
	  </div>
    </div> <!-- /container -->
	{literal}
    <script>
      function initMap() {

        $.ajax({ 
			type: 'GET', 
			url: '/ajax/stations', 
			data: { get_param: 'value' }, 
			dataType: 'json',
			success: function (data) { 
				var markers = [];
				
				var map = new google.maps.Map(document.getElementById('map'), {
				  zoom: 11,
				  center: {lat: 50.935807, lng: -1.396226} 
				});
				
				$.each(data, function(index, element) {
			
					
					var marker = new google.maps.Marker({
					  position: {lat: parseFloat(element.lat), lng: parseFloat(element.lng)},
					  label: element.name,
					  map: map,
					  title: 'Click to zoom'
					});
					
					marker.addListener('click', function() {
					  map.setZoom(15);
					  map.setCenter(marker.getPosition());
					});
					
					markers.push(marker);
				});
				
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