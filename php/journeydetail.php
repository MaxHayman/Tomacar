<?php
/*
$id = 1;
$stmt = $conn->query('SELECT
journey.id,
st.`name` as st,
en.`name` as en,
journey.`start`,
journey.`end`,
journey.`us`
FROM
journey
INNER JOIN stations st ON journey.`from` = st.id
INNER JOIN stations en ON journey.`to` = en.id
WHERE
journey.`user` = 1
');

$journeys = array();
while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
	$journey = array();
	$journey['startLocation'] = $row['st'];
	$journey['endLocation'] = $row['en'];
	$journey['start'] = $row['start'];
	$journey['end'] = $row['end'];
	
	$time = ($row['end'] - $row['start']);
	$hours = floor($time / (60 * 60));
	$mins = floor( ($time / 60) % 60);
	$secs = $time % 60;
	
	
	$journey['duration'] = "$hours h $mins m $secs s";
	
	$journeys[$row['id']] = $journey;
}
*/
if(!isset($_GET['id']) || empty($_GET['id'])) {
$_SESSION["messages"]['danger'] = '<strong>Error!</strong> No valid journey selected.';
	Header('Location: /');
}

$jd = $conn->query('SELECT
f.`name` AS fromStation,
t.`name` AS toStation,
f.lat as flat,
f.lng as flng,
t.lat as tlat,
t.lng as tlng,
j.id,
j.car,
j.`from`,
j.`to`,
j.`start`,
j.`end`
FROM
journey as j
INNER JOIN stations as f ON j.`from` = f.id
INNER JOIN stations as t ON t.id = j.`to`
WHERE j.id = '.$_GET['id'].' LIMIT 1');

$row = $jd->fetch(PDO::FETCH_ASSOC);
	$detail = array();
	$detail['journeyId'] = $row['id'];
	$detail['journeyCar'] = $row['car'];
	$detail['startName'] = $row['fromStation'];
	$detail['endName'] = $row['toStation'];
	//$detail['startLocation'] = $row['from'];
	//$detail['endLocation'] = $row['to'];
	$detail['fromLat'] = $row['flat'];
	$detail['fromLng'] = $row['flng'];
	$detail['toLat'] = $row['tlat'];
	$detail['toLng'] = $row['tlng'];
	$detail['start'] = $row['start'];
	$detail['end'] = $row['end'];
	
	$time = ($row['end'] - $row['start']);
	$hours = floor($time / (60 * 60));
	$mins = floor( ($time / 60) % 60);
	$secs = $time % 60;
	
	
	$detail['duration'] = "$hours h $mins m $secs s";

$smarty->assign('journey', $detail);
/*echo '<pre>';
var_dump($journeys);
echo '</pre>';
	die;*/
// display it
$smarty->display('journeydetail.tpl');