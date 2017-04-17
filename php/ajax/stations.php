<?php

$stmt = $conn->query('SELECT
stations.id,
stations.`name`,
stations.capacity,
stations.lat,
stations.lng,
count(stations.id) as count
FROM
stations
LEFT JOIN cars ON stations.id = cars.station
GROUP BY
stations.id
');

$stations = array();
while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
	$station = array();
	$station['name'] = $row['name'];
	$station['capacity'] = $row['capacity'];
	$station['lat'] = $row['lat'];
	$station['lng'] = $row['lng'];
	$station['count'] = $row['count'];
	
	$stations[$row['id']] = $station;
}

echo json_encode($stations);