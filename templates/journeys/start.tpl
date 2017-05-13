{include file='header.tpl'}

      <!-- Main component for a primary marketing message or call to action -->
      <div class="row">
		<div class="col-md-{if $suggestions}6{else}12{/if}">
			<div class="jumbotron">
				<p class="text-center"><b>{$station.name}</b></p>
				<div class="text-center">
					{for $count=1 to $station.high}
						<i class='fa fa-car fa-fw' style='color:green;' aria-hidden='true'></i>
					{/for}
					{for $count=1 to $station.medium}
						<i class='fa fa-car fa-fw' style='color:yellow;' aria-hidden='true'></i>
					{/for}
					{for $count=1 to $station.low}
						<i class='fa fa-car fa-fw' style='color:red;' aria-hidden='true'></i>
					{/for}

				</div>
			
        {if ($station.count / $station.capacity) >= 0.7}
				<p class="text-center">Experience discount from this station!</p>
		
		
		{/if}
        <p>
        	{if $station.count == 0}
        		This station doesnt have any cars left.
        	{else if ($station.count / $station.capacity) < 0.3} 
        		This station doesnt have many cars left.
        	{/if}
			
        </p>
{if $station.count > 0}
					<form method="POST">
						<input type="hidden" name="start" value="{$station.id}">
						<button class="btn btn-lg btn-primary btn-block" type="submit">Commence Journey</button>
					</form>
		
      {/if}
	  </div>
      		</div>
      
      	{if $suggestions}
		<div class="col-md-6">
			<div id="locations" class="jumbotron">
				<p>
				<b>Discount if you pick up a car from one of these...</b>
				</p>

				{foreach from=$suggestions item=suggestion}
			         <div class="text-center"><b>{$suggestion.name}</b></div>
						<div class="text-center">
							{for $count=1 to $suggestion.high}
								<i class='fa fa-car fa-fw' style='color:green;' aria-hidden='true'></i>
							{/for}
							{for $count=1 to $suggestion.medium}
								<i class='fa fa-car fa-fw' style='color:yellow;' aria-hidden='true'></i>
							{/for}
							{for $count=1 to $suggestion.low}
								<i class='fa fa-car fa-fw' style='color:red;' aria-hidden='true'></i>
							{/for}
						</div>
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