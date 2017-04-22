{include file='header.tpl'}

      <!-- Main component for a primary marketing message or call to action -->
      <div class="row">
		<div class="col-md-{if $suggestions}6{else}12{/if}">
      <div class="jumbotron">
        <p><b>{$station.name}</b> {$station.count}/{$station.capacity}</p>
        {if $suggestions}
        <p>
        	{if $station.count == 0}
        		This station doesnt have any cars left.
          
        	{else} 
        		This station doesnt have many cars left.
        	{/if}

        </p>
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
			         <div><b>{$suggestion.name}</b> {$suggestion.count}/{$suggestion.capacity}</div>
			      {/foreach}

				
			</div>
		</div>
		{/if}
	  </div>


{include file='footer.tpl'}