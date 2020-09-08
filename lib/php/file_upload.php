<?php
  $response = array();
  $name = $_POST['name'];
  $path = $_POST['path'];
  $image = $_FILES['image']["tmp_name"];
  $Path = $path.$name;
  $uploadFile = uploadedFile($path, $name);
  $response = array();

  if(move_uploaded_file($image, $uploadFile)){
    $response["response"] = "true";
  }else{
    $response["response"] = "false";
  }

  function uploadedFile($uploadPath, $fileName) {
      return iconv("utf-8", "CP949", $uploadPath.basename2($fileName));
  }

  function basename2($filename) {
      return preg_replace( '/^.+[\\\\\\/]/', '', $filename);
  }
  echo json_encode($response);
?>
