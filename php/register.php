<?php


if($user) {
	Header('Location: /');
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

	$stmt = $conn->prepare('SELECT * FROM `users` WHERE `email` = :email');
	$stmt->bindParam(':email', $_POST['email']);
	$result = $stmt->execute();

	if(!$result) {
		echo "Error"; die;
	}
	
	$row = $stmt->fetch(PDO::FETCH_ASSOC);

	if($row) {
		//echo "gi";die;
		$_SESSION["messages"]['danger'] = '<strong>Failed!</strong> email address already in use.';

		Header('Location: /register');
	} else {

		require_once('lib/password_compat/lib/password.php');
		$stmt = $conn->prepare('INSERT INTO 
		`users` 
		(`email`, `password`, `firstName`, `lastName`)
		VALUES 
		(:email, :password, :firstName, :lastName)');

		$stmt->bindParam(':email', $_POST['email']);
		$stmt->bindParam(':password', password_hash($_POST['password'], PASSWORD_DEFAULT));
		$stmt->bindParam(':firstName', $_POST['firstName']);
		$stmt->bindParam(':lastName', $_POST['lastName']);
		
	    $result = $stmt->execute();

	    $_SESSION["messages"]['success'] = '<strong>Success!</strong> Your account has been registered. You can now login.';

		Header('Location: /login');
	}
}

// display it
$smarty->display('register.tpl');