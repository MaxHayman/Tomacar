<?php

$stmt = $conn->query('SELECT
stations.id,
stations.`name`,
stations.capacity,
stations.lat,
stations.lng,
sum(case when cars.id IS NOT NULL then 1 else 0 end) as count,
sum(case when cars.charge >= 75 then 1 else 0 end) as high,
sum(case when cars.charge >= 50 AND cars.charge < 75 then 1 else 0 end) as medium,
sum(case when cars.charge < 50  then 1 else 0 end) as low
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
	$station['high'] = $row['high'];
	$station['medium'] = $row['medium'];
	$station['low'] = $row['low'];
	
	$stations[$row['id']] = $station;
}

echo json_encode($stations);