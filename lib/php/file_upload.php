<?php
  $response = array();

  $image = $_FILES['image'];
  $postPath = $_POST["path"];
  echo "size : ".$image['size']."\n";
  echo "type : ".$image['type']."\n";
  echo $image['name']."\n";
  echo $image['tmp_name']."\n";
  
  $path = $postPath.$image["name"];
  echo $path."\n";

  if(move_uploaded_file($image['tmp_name'], $path)){
    $response["response"] = true;
  }else{
    $response["response"] = false;
  }
  echo json_encode($response);
  
?>
