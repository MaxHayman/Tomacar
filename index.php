<?php

include('config.php');
include('lib/smarty/libs/Smarty.class.php');

// create object
$smarty = new Smarty;
$user = null;

//db
$host = $config['database']['host'];
$user = $config['database']['user'];
$pass = $config['database']['pass'];
$db = $config['database']['db'];
$conn = new PDO("mysql:host=$host;dbname=$db", $user, $pass);

// Logged in
session_start();
if(isset($_SESSION['id'])) {
		$stmt = $conn->prepare('SELECT
users.id,
users.email,
users.`password`,
users.firstName,
users.lastName
FROM
users
WHERE
users.id = :id LIMIT 1');

	$stmt->bindParam(':id', $_SESSION['id']);
	
    $result = $stmt->execute();

    if(!$result) {
		echo "Error"; die;
	}

	$row = $stmt->fetch(PDO::FETCH_ASSOC);
	$user = $row;
} else {
	$user = false;
}

$journey = true;

$smarty->assign('title', $config['website']['title']);
$smarty->assign('user', $user);
$smarty->assign('injourney', false);
$smarty->debugging = true;

// System messages
$messages = isset($_SESSION["messages"]) ? $_SESSION["messages"] : array() ;
$_SESSION["messages"] = array();
$smarty->assign('messages', $messages);

$path = isset($_GET['path']) ? $_GET['path'] : 'index';

if (file_exists('php/'.$path.'.php')) {
	require_once('php/'.$path.'.php');
} else {
	require_once('php/404.php');
}