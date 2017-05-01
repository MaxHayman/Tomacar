<?php

$stmt = $conn->query('SELECT
users.id,
users.email,
users.`password`,
users.firstName,
users.lastName
FROM
users
WHERE
users.id = $_GET[id]
LIMIT 1
');

$users = array();

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
		
		$_SESSION["messages"]['success'] = '<strong>Success!</strong> Your message has been sent. The admin will reply to you as soon as possible.';

		Header('Location: /');

}
// display it
$smarty->display('contact.tpl');