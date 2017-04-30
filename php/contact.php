<?php
var_dump($_POST);
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		$stmt = $conn->prepare('INSERT INTO 
		`messages` 
		(`name`, `email`, `mobile`, `subject`, `message`)
		VALUES 
		(:name, :email, :mobile, :subject, :message)');

		$stmt->bindParam(':name', $_POST['name']);
		$stmt->bindParam(':email', $_POST['email']);
		$stmt->bindParam(':mobile', $_POST['mobile']);
		$stmt->bindParam(':subject', $_POST['subject']);
		$stmt->bindParam(':message', $_POST['message']);
		
	    $result = $stmt->execute();
		var_dump ($conn->errorInfo());
		var_dump( $result);
echo "POST";die;
}
// display it
$smarty->display('contact.tpl');