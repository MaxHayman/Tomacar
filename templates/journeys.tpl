{include file='header.tpl'}

	<br><h2>Your Journeys</h2><br>
	  <table class="table table-striped">
		<thead>
		  <tr>
			<th>Id</th>
			<th>From</th>
			<th>To</th>
			<th>Duration</th>
		  </tr>
		</thead>
		<tbody>
		{foreach from=$journeys key=id item=journey}
		  <tr>
			<td><a href="/journeydetail?id={$id}">{$id}</a></td>
			<td>{$journey.startLocation}</td>
			<td>{$journey.endLocation}</td>
			<td>{$journey.duration}</td>
		  </tr>
		{/foreach}
		</tbody>
	  </table>
  
{include file='footer.tpl'}