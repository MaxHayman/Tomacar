<?php

include('config.php');
include('lib/smarty/libs/Smarty.class.php');

// create object
$smarty = new Smarty;

// assign some content. This would typically come from
// a database or other source, but we'll use static
// values for the purpose of this example.
$smarty->assign('title', $config['website']['title']);
$smarty->assign('address', '45th & Harris');

$path = isset($_GET['path']) ? $_GET['path'] : 'index';

if (file_exists('php/'.$path.'.php')) {
	require_once('php/'.$path.'.php');
} else {
	require_once('php/404.php');
}