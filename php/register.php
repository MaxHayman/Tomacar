<?php


if($user) {
	Header('Location: /');
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
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
}

// display it
$smarty->display('register.tpl');