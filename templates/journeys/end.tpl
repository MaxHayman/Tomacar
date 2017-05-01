{include file='header.tpl'}
      <!-- Main component for a primary marketing message or call to action -->
      <div class="row">
		<div class="col-md-{if $suggestions}6{else}12{/if}">
      <div class="jumbotron">
        <p class="text-center"><b>{$station.name}</b></p>
			<div class="text-center">
				{for $count=1 to $to max={$station.capacity - $station.count}}
					<i class='fa fa-road' aria-hidden='true'></i>
				{/for}
			</div>
        {if (($station.capacity - $station.count) / $station.capacity) >= 0.75}
				<p class="text-center">Experience discount returning to this station!</p>
		
		
		{/if}
        <p>
        	{if $station.capacity - $station.count == 0}
        		This station doesnt have any spaces left.
        	{else if (($station.capacity - $station.count) / $station.capacity) <= 0.25} 
        		This station doesnt have many spaces left.
        	{/if}
			
        </p>
				{if $station.capacity - $station.count > 0}
					<form method="POST">
						<input type="hidden" name="end" value="{$station.id}">
						<button class="btn btn-lg btn-primary btn-block" type="submit">End Journey</button>
					<form>
				</div>
				{/if}
      		</div>
      
      	{if $suggestions}
		<div class="col-md-6">
			<div id="locations" class="jumbotron">
				<p>
				<b>Discount if you return your car to one of these...</b>
				</p>
				{foreach from=$suggestions item=suggestion}
				
			        <div class="text-center"><b>{$suggestion.name}</b></div>
					<div class="text-center">
						{for $count=1 to $to max={$suggestion.capacity - $suggestion.count}}
							<i class='fa fa-road' aria-hidden='true'></i>
						{/for}
					</div>
					<p> 
						<form method="POST">
							<input type="hidden" name="end" value="{$suggestion.id}">
							<button class="btn btn-lg btn-primary btn-block" type="submit">End Journey</button>
						<form>
					</p>
			    {/foreach}
			</div>
		</div>
		{/if}
	  </div>


{include file='footer.tpl'}