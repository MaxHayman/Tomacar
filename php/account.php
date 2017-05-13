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
journey.`discount`,
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
	$journey['discount'] = $row['discount'];
	
	$time = ($row['end'] - $row['start']);
	$mins = ceil($time / 60);
	
	$hours = floor($time / (60 * 60));
	$mins2 = floor( ($time / 60) % 60);
	$secs = $time % 60;
	
	
	$journey['duration'] = "$hours h $mins2 m $secs s";
	$journey['cost'] = ($mins * $row['price']);
	$journey['damount'] = ($journey['cost'] * $journey['discount']);
	$journey['dpercent'] = ($journey['discount'] * 100);
	$journey['dcost'] = ($journey['cost'] - $journey['damount']); 
	
	$journeys[] = $journey;
	
}

$smarty->assign('journeys', $journeys);

// display it
$smarty->display('account.tpl');