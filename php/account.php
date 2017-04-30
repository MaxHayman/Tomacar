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

$id = $user['id'];

$jtmt = $conn->query('SELECT
journey.id,
journey.`start`,
journey.`end`,
cars.price
FROM
users
INNER JOIN journey ON users.id = journey.`user`
INNER JOIN cars ON journey.car = cars.id
WHERE
journey.`user` = '.$id.'
');
$journeys = array();


while($row = $jtmt->fetch(PDO::FETCH_ASSOC)) {
	$journey = array();

	$journey['id']= $row['id'];
	$journey['price'] = $row['price'];
	
	$time = ($row['end'] - $row['start']);
	$mins = floor( ($time / 60) % 60);
	
	$journey['duration'] = $mins;
	
	$journeys[$row['id']] = $journey;
	
}

$smarty->assign('journeys', $journey);

// display it
$smarty->display('account.tpl');