<?php

if($user) {
	Header('Location: /');
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	
	require_once('lib/password_compat/lib/password.php');
	$stmt = $conn->prepare('SELECT
users.id,
users.email,
users.`password`,
users.firstName,
users.lastName
FROM
users
WHERE
users.email = :email LIMIT 1');

	$stmt->bindParam(':email', $_POST['inputEmail']);
	
    $result = $stmt->execute();
	
	if(!$result) {
		echo "Error"; die;
	}
	
	$row = $stmt->fetch(PDO::FETCH_ASSOC);
	
	// Verify Password
	if($row && password_verify($_POST['inputPassword'], $row['password'])) {
		session_regenerate_id(true);
		$_SESSION['id'] = $row['id'];
		$_SESSION["messages"]['success'] = '<strong>Success!</strong> You have logged in.';
		Header('Location: /');
	} else {
		$_SESSION["messages"]['danger'] = '<strong>Failed!</strong> invalid email/password combination.';
	}
}

// display it
$smarty->display('login.tpl');

