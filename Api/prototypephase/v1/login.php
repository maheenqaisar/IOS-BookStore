<?php
require_once '../includes/DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    if (isset($_POST['username']) && isset($_POST['password'])) {

        $db = new DbOperation();

        if ($db->userLogin($_POST['username'], $_POST['password'])) {
            $response['error'] = false;
            $response['user'] = $db->getUserByUsername($_POST['username']);
        } else {
            $response['error'] = true;
            $response['message'] = 'Invalid username or password';
        }

    } else {
        $response['error'] = true;
        $response['message'] = 'Parameters are missing';
    }

} else {
    $response['error'] = true;
    $response['message'] = "Request not allowed";
}

echo json_encode($response);