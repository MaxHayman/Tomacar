<?php

if(!isset($_GET['start']) || empty($_GET['start'])) {
$_SESSION["messages"]['danger'] = '<strong>Error!</strong> No journey start.';
	Header('Location: /');
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
	HAVING distance < 25
	ORDER BY distance';

	$stmt = $conn->query($closest);

	$suggestions = array();
	while($suggestion = $stmt->fetch(PDO::FETCH_ASSOC)) {
		$suggestions[] = $suggestion;
	}
}

$smarty->assign('suggestions', $suggestions);

// display it
$smarty->display('journeys/start.tpl');