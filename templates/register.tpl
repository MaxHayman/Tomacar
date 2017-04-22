{include file='header.tpl'}
<div class="jumbotron">
	<div class="container">
		<div class="col-md-3">&nbsp;</div>
		<div class="col-md-6 text-center">
			<div class="form-area">  
				<form class="form-register" method="POST">
				<br style="clear:both">
							<h3 style="margin-bottom: 25px; text-align: center;">Register an Account Today!</h3>
							<div class="form-group">
								<input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
							</div>
							<div class="form-group">
								<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Surname" required>
							</div>
							<div class="form-group">
								<input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
							</div>
							<div class="form-group">
								<input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
							</div>
					
				<button type="submit" class="btn btn-primary">Register</button>
				</form>
			</div>
		</div>
		<div class="col-md-3">&nbsp;</div>
		
	
	</div> <!-- /container -->
</div>

{include file='footer.tpl'}