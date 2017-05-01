<?php

if(!isset($_GET['end']) || empty($_GET['end'])) {
$_SESSION["messages"]['danger'] = '<strong>Error!</strong> No journey end.';
	Header('Location: /');
		die;
}

if(!$user) {
	$_SESSION["messages"]['danger'] = '<strong>Error!</strong> You are not logged in.';
	Header('Location: /login');
		die;
}

if(!$journey) {
	$_SESSION["messages"]['danger'] = '<strong>Error!</strong> You dont have a journey.';
	Header('Location: /');
		die;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

	$id = $journey['id'];
	
	
	$stmt = $conn->prepare('SELECT journey.discount FROM journey');
	$discount = $journey['discount'];
	if(isset($_POST['refer'])) {
		$discount = $discount + 0.3;
	}

	if(!isset($_POST['end'])) {
		$_SESSION["messages"]['danger'] = '<strong>Error!</strong> 987.';
		Header('Location: /');
		die;
	}

	$status = 1;
	$time = time();
	$stmt = $conn->prepare('UPDATE `journey` SET `to` = :station, `end`= :time, `status`= :status WHERE (`id`=:id) LIMIT 1');
	$stmt->bindParam(':status', $status);
	$stmt->bindParam(':id', $id);
	$stmt->bindParam(':time', $time);
	$stmt->bindParam(':station', $_POST['end']);

    $result = $stmt->execute();

    if(!$result) {
		$_SESSION["messages"]['danger'] = '<strong>Error!</strong> could not end journey.';
		Header('Location: /');
		die;
    }

    $stmt = $conn->prepare('UPDATE `cars` SET `station`=:station WHERE (`id`=:car) LIMIT 1');
	$stmt->bindParam(':station', $_POST['end']);
	$stmt->bindParam(':car', $journey['car']);

	$result = $stmt->execute();

    if(!$result) {
		$_SESSION["messages"]['danger'] = '<strong>Error!</strong> could not end car.';
		Header('Location: /');
		die;
    }


    $_SESSION["messages"]['success'] = '<strong>Success!</strong> Journey complete.';
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
WHERE stations.id = '.$_GET['end'].'
LIMIT 1';

$stmt = $conn->query($station);

if(!$stmt) {
	$_SESSION["messages"]['danger'] = '<strong>Error!</strong> Invalid end.';
	Header('Location: /');
}

$station = $stmt->fetch(PDO::FETCH_ASSOC);
$smarty->assign('station', $station);


$suggestions = false;
if(($station['capacity'] - $station['count']) / $station['capacity'] <= 0.3) {
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
	WHERE s.id <> '.$_GET['end'].'
	GROUP BY
	s.id
	HAVING distance < 0.6
	ORDER BY distance';

	$stmt = $conn->query($closest);

	$suggestions = array();
	while($suggestion = $stmt->fetch(PDO::FETCH_ASSOC)) {
		//calculates whether the difference between the suggested stations is > 30%
		if(($suggestion['capacity'] - $suggestion['count'])/$suggestion['capacity'] - ($station['capacity'] - $station['count']) / ($station['capacity']) > 0.3 ){
			$suggestions[] = $suggestion;
		}
	}
}

$smarty->assign('to',15);
$smarty->assign('suggestions', $suggestions);


// display it
$smarty->display('journeys/end.tpl');