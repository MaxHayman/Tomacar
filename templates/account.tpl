{include file='header.tpl'}

	<div class="container">

		<h1>Account</h1>
			<table class="table table-striped">
				<thead>
				  <tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
				  </tr>
				</thead>
				<tbody>
					<tr>
						<td>{$user.firstName}</td>
						<td>{$user.lastName}</td>
						<td>{$user.email}</td>
					</tr>
				</tbody>
			</table>
	
	</div> <!-- /container -->

{include file='footer.tpl'}