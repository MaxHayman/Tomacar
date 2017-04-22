{include file='header.tpl'}


    <div class="jumbotron">
	  
        <div class="container">

		  <form class="form-signin" method="POST">
			<h1 class="text-center"> Tomacar </h1>
			<h2 class="text-center">Please sign in</h2></br>
		
			<div class="row">
				<div class="col-md-4">&nbsp;</div>
				<div class="col-md-4">
						<label for="inputEmail" class="sr-only">Email address</label>
						<input type="email" name="inputEmail" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
						<br />
						<label for="inputPassword" class="sr-only">Password</label>
						<input type="password" name="inputPassword" id="inputPassword" class="form-control" placeholder="Password" required>
						
					<div class="checkbox">
					<label>
						<input type="checkbox" value="remember-me"> Remember me
					</label>
					
					<label>
						<div><a href="/register">Don't have an account? Register today!</a></div>
					</label>
				</div>
				<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
			
		
			</form>

		</div> <!-- /container -->

    </div> <!-- /container -->

{include file='footer.tpl'}