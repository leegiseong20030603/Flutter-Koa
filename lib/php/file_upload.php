<?php
  $response = array();
  $image = $_FILES['image'];
  if(move_uploaded_file($image['tmp_name'], $image['name'])){
    $response["response"] = "true";
  }else{
    $response["response"] = "false";
  }
  echo json_encode($response);
?>