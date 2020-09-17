<?php
  $response = array();

  $image = $_FILES['image'];
  $postPath = $_POST["path"];
  echo $image['name'];
  echo $image['tmp_name'];
  
  $path = $postPath.$image["name"];

  if(move_uploaded_file($image['tmp_name'], $path)){
    $response["response"] = true;
  }else{
    $response["response"] = false;
  }
  echo json_encode($response);
  
?>
