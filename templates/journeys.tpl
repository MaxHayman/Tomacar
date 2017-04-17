{include file='header.tpl'}

	<br><h2>Your Journeys</h2><br>
	  <table class="table table-striped">
		<thead>
		  <tr>
			<th>Id</th>
			<th>From</th>
			<th>To</th>
			<th>Start</th>
			<th>End</th>
			<th>Duration</th>
		  </tr>
		</thead>
		<tbody>
		{foreach from=$journeys key=id item=journey}
		  <tr>
			<td>{$id}</td>
			<td>{$journey.startLocation}</td>
			<td>{$journey.endLocation}</td>
			<td>{$journey.start|date_format:"%c"}</td>
			<td>{$journey.end|date_format:"%c"}</td>
			<td>{$journey.duration}</td>
		  </tr>
		{/foreach}
		</tbody>
	  </table>
  
{include file='footer.tpl'}