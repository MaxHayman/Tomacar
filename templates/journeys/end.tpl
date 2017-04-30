{include file='header.tpl'}

      <!-- Main component for a primary marketing message or call to action -->
      <div class="row">
		<div class="col-md-12">
      <div class="jumbotron">
        <p><b>{$station.name}</b> {$station.count}/{$station.capacity}</p>
  
				<p> 
				<form method="POST">
					<input type="hidden" name="end" value="{$station.id}">
					<button class="btn btn-lg btn-primary btn-block" type="submit">End</button>
					<form>
				</p>
      </div>
      		</div>
	  </div>


{include file='footer.tpl'}