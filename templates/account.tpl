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
			{foreach from=$journeys key=id item=journey}
			  <tr>
				<td>{$journey.id}</td>
				<td>{$journey.price}</td>
				<td>{$journey.duration}</td>
			  </tr>
			{/foreach}
			</tbody>
		  </table>
		
		
	
	</div> <!-- /container -->

{include file='footer.tpl'}