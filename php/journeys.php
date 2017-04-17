<?php
$id = 1;
$stmt = $conn->query('SELECT
journey.id,
st.`name` as st,
en.`name` as en,
journey.`start`,
journey.`end`,
journey.`status`
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

$smarty->assign('journeys', $journeys);
/*echo '<pre>';
var_dump($journeys);
echo '</pre>';
	die;*/
// display it
$smarty->display('journeys.tpl');