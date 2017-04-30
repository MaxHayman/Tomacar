{include file='header.tpl'}

	<div class="container">

		<h1>Account</h1><br><br>
			<table class="table table-striped">
					<tr>
						<th>First Name</th>
						<td>{$user.firstName}</td>
					</tr>
					<tr>
						<th>Last Name</th>
						<td>{$user.lastName}</td>
					</tr>
					<tr>
						<th>Email</th>
						<td>{$user.email}</td>
					</tr>
			</table><br><br>
			
		<h3>Payment Information</h3>
		
		<table class="table table-striped">
			<tbody>
				<tr>
					<td>Journey ID</td>
					<td>Price per KM</td>
					<td>Duration</td>
					<td>Cost</td>
					<td>Discounted Cost (if applicable)</td>
				</tr>
			{foreach from=$journeys key=id item=journey}
				<tr>
					<td><a href="/journeydetail?id={$journey.id}">{$journey.id}</td>
					<td>{$journey.price}p</td>
					<td>{$journey.duration}</td>
					<td>£{$journey.cost|string_format:"%.2f"}</td>
				</tr>
			{/foreach}
			</tbody>
		  </table>
		
		
	
	</div> <!-- /container -->

{include file='footer.tpl'}