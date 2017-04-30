{include file='header.tpl'}

	<div class="container">
		<div class="col-md-3">&nbsp;</div>
		<div class="col-md-6 text-center">
			<div class="form-area">  
				<form class="form" method="POST">
				<br style="clear:both">
							<h3 style="margin-bottom: 25px; text-align: center;">Contact Form</h3>
							<div class="form-group">
								<input type="text" class="form-control" id="name" name="name" placeholder="Name" required>
							</div>
							<div class="form-group">
								<input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
							</div>
							<div class="form-group">
								<input type="number" class="form-control" id="mobile" name="mobile" placeholder="Mobile Number" required>
							</div>
							<div class="form-group">
								<input type="text" class="form-control" id="subject" name="subject" placeholder="Subject" required>
							</div>
							<div class="form-group">
							<textarea class="form-control" type="textarea" id="message" name="message" placeholder="Message" maxlength="2000" rows="7"></textarea>                   
							</div>
					
				<button type="submit" class="btn btn-primary">Submit Form</button>
				</form>
			</div>
		</div>
		<div class="col-md-3">&nbsp;</div>
		
	
	</div> <!-- /container -->

{include file='footer.tpl'}