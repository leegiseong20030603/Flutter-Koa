<?php
    include "connect.php";
    mysqli_query($con,'SET NAMES utf8');

    $User_ID = $_POST["User_ID"];
    $User_PW = $_POST["User_PW"];
    $statement = mysqli_prepare($con, "SELECT * FROM user WHERE User_ID = ? AND User_PW = ?");
    
    mysqli_stmt_bind_param($statement, "ss", $User_ID, $User_PW);
    mysqli_stmt_execute($statement);

    mysqli_stmt_store_result($statement);
    mysqli_stmt_bind_result($statement, $User_ID, $User_PW, $User_Name, $User_Email, $User_Birthday, $User_Type, $User_Agree);

    $response = array();
    $response["response"] = false;
 
    while(mysqli_stmt_fetch($statement)) {
        $response["response"] = true;
        $response["User_ID"] = $User_ID;
        $response["User_PW"] = $User_PW;
        $response["User_Name"] = $User_Name;
        $response["User_Email"] = $User_Email;    
        $response["User_Birthday"] = $User_Birthday;    
        $response["User_Type"] = $User_Type;
    }
    echo json_encode($response);

?>