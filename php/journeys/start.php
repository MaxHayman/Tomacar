<?php

if(!isset($_GET['start']) || empty($_GET['start'])) {
$_SESSION["messages"]['danger'] = '<strong>Error!</strong> No journey start.';
	Header('Location: /');
}

if(!$user) {
	$_SESSION["messages"]['danger'] = '<strong>Error!</strong> You are not logged in.';
	Header('Location: /login');
	die;
}

if($journey) {
	$_SESSION["messages"]['danger'] = '<strong>Error!</strong> You are already in a journey.';
	Header('Location: /');
	die;
}


$station = 'SELECT
stations.id,
stations.`name`,
stations.capacity,
stations.lat,
stations.lng,
sum(case when cars.id IS NOT NULL then 1 else 0 end) as count
FROM
stations
LEFT JOIN cars ON stations.id = cars.station
WHERE stations.id = '.$_GET['start'].'
LIMIT 1';

$stmt = $conn->query($station);

if(!$stmt) {
	$_SESSION["messages"]['danger'] = '<strong>Error!</strong> Invalid start.';
	Header('Location: /');
}

$station = $stmt->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

	$discount = 0;
	if(isset($_POST['refer'])) {
		$discount = 0.3;
	} else if ($station['count'] > ($station['capacity']*0.75)) {
		$discount = 0.3;
	}

	if(!isset($_POST['start'])) {
		$_SESSION["messages"]['danger'] = '<strong>Error!</strong> 986.';
		Header('Location: /');
		die;
	}

	$from = $_POST['start'];
	$stmt = $conn->prepare('SELECT * FROM `cars` WHERE `station` = :from LIMIT 1');
	$stmt->bindParam(':from', $from);

	$result = $stmt->execute();

	$row = $stmt->fetch(PDO::FETCH_ASSOC);

	if(!$result) {
		$_SESSION["messages"]['danger'] = '<strong>Error!</strong> No cars from this location.';
		Header('Location: /');
		die;
	}


	$car = $row['id'];
	$station = 0;
    $stmt = $conn->prepare('UPDATE `cars` SET `station`=:station WHERE (`id`=:car) LIMIT 1');
	$stmt->bindParam(':station', $station);
	$stmt->bindParam(':car', $car);

	$result = $stmt->execute();

    if(!$result) {
		$_SESSION["messages"]['danger'] = '<strong>Error!</strong> could not start car.';
		Header('Location: /');
		die;
    }

	$time = time();
	$to = 0;
	$end = 0;
	$status = 0;
	$stmt = $conn->prepare('INSERT INTO `journey` (`user`, `car`, `from`, `to`, `start`, `end`, `status`, `discount`) VALUES (:user, :car, :from, :to, :time, :end, :status, :discount)');
	$stmt->bindParam(':user', $user['id']);
	$stmt->bindParam(':car', $car);
	$stmt->bindParam(':from', $from);
	$stmt->bindParam(':end', $end);
	$stmt->bindParam(':status', $status);
	$stmt->bindParam(':to', $to);
	$stmt->bindParam(':time', $time);
	$stmt->bindParam(':discount', $discount);

    $result = $stmt->execute();

    if(!$result) {
		$_SESSION["messages"]['danger'] = '<strong>Error!</strong> could not start journey.';
		Header('Location: /');
		die;
    }

    $_SESSION["messages"]['success'] = '<strong>Success!</strong> Journey started.';
	Header('Location: /');
	die;
}

$smarty->assign('station', $station);

$suggestions = false;
if($station['count'] < ($station['capacity']*0.3)) {
	$suggestions = true;
}

if($suggestions) {
	$closest = 'SELECT s.name, s.id, s.lat, s.lng, SQRT(
	    POW(69.1 * (lat - '.$station['lat'].'), 2) +
	    POW(69.1 * ('.$station['lng'].' - lng) * COS(lat / 57.3), 2)) AS distance,
	sum(case when cars.id IS NOT NULL then 1 else 0 end) as count,
	s.capacity
	FROM
	stations s
	LEFT JOIN cars ON cars.station = s.id
	WHERE s.id <> '.$_GET['start'].'
	GROUP BY
	s.id
	HAVING distance < 0.6
	ORDER BY distance';

	$stmt = $conn->query($closest);

	$suggestions = array();
	while($suggestion = $stmt->fetch(PDO::FETCH_ASSOC)) {
		//calculates whether the difference between the suggested stations is > 30%
		if(($suggestion['count']/$suggestion['capacity'] -  $station['count']/$station['capacity']) > 0.3 ){
			$suggestions[] = $suggestion;
			
		}
	}
}

$smarty->assign('to',15);
$smarty->assign('suggestions', $suggestions);

// display it
$smarty->display('journeys/start.tpl');