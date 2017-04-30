<?php

if(!$user) {
	$_SESSION["messages"]['danger'] = '<strong>Error!</strong> You need to log in.';
	Header('Location: /login');
}


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


// display it
$smarty->display('account.tpl');