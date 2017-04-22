<?php

if(!isset($_GET['start']) || empty($_GET['start'])) {
$_SESSION["messages"]['danger'] = '<strong>Error!</strong> No journey start.';
	Header('Location: /');
} 

else {
	echo "Start: ".$_GET['start'];
}