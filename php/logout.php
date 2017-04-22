<?php

unset($_SESSION['id']);
$_SESSION["messages"]['warning'] = '<strong>Success!</strong> You have logged out.';
Header('Location: /');
