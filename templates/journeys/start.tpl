{include file='header.tpl'}

      <!-- Main component for a primary marketing message or call to action -->
      <div class="row">
		<div class="col-md-{if $suggestions}6{else}12{/if}">
      <div class="jumbotron">
        <p><b>{$station.name}</b> {$station.count}/{$station.capacity}</p>
        {if ($station.count / $station.capacity) >= 0.75}
				<p>Experience discount from this station!</p>
		
		
		{/if}
        <p>
        	{if $station.count == 0}
        		This station doesnt have any cars left.
        	{else if ($station.count / $station.capacity) < 0.25} 
        		This station doesnt have many cars left.
        	{/if}
			
        </p>
{if $station.count > 0}
			<form method="POST">
									<input type="hidden" name="start" value="{$station.id}">
					<button class="btn btn-lg btn-primary btn-block" type="submit">Commence Journey</button>
					</form>
      </div>
      {/if}
      		</div>
      
      	{if $suggestions}
		<div class="col-md-6">
			<div id="locations" class="jumbotron">
				<p>
				<b>Discount if you pick up a car from one of these...</b>
				</p>

				{foreach from=$suggestions item=suggestion}
			         <div><b>{$suggestion.name}</b> {$suggestion.count}/{$suggestion.capacity}</div>
						<p> 
						<form method="POST">
									<input type="hidden" name="start" value="{$suggestion.id}">
									<input type="hidden" name="refer" value="{$station.id}">
								<button class="btn btn-lg btn-primary btn-block" type="submit">Commence Journey</button>
								</form>
						</p>
			      {/foreach}
				  
				  

				
			</div>
		</div>
		{/if}
	  </div>


{include file='footer.tpl'}