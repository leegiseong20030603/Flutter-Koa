<?php
    include "connect.php";

    if(!empty($_POST)){
		$User_ID = $_POST["User_ID"];
    	$User_PW = $_POST["User_PW"];
    	$User_Name = $_POST["User_Name"];
    	$User_Email = $_POST["User_Email"];
  	 	$User_Birthday = $_POST["User_Birthday"];
		$User_Type = $_POST["User_Type"];
		$User_Agree = $_POST["User_Agree"];
	}

	$check_user_sql = mysqli_query($con, "SELECT * FROM user WHERE User_ID = '{$User_ID}'");
	$check_user_result = mysqli_num_rows($check_user_sql);
	$response = array();
	if(!$check){
		$sql = "INSERT INTO user (User_ID, User_PW, User_Name, User_Email, User_Birthday, User_Type, User_Agree) VALUES 
		('$User_ID','$User_PW','$User_Name','$User_Email','$User_Birthday','$User_Type','$User_Agree')";
		$result = mysqli_query($con,$sql);
		if($result){
			$response["response"] = true;
    		$response["User_ID"] = $User_ID;
    		$response["User_PW"] = $User_PW;
    		$response["User_Name"] = $User_Name;
    		$response["User_Email"] = $User_Email;
    		$response["User_Birthday"] = $User_Birthday;
			$response["User_Type"] = $User_Type;
		//	$response["User_Agree"] = $User_Agree;
		}else{
			$response["response"] = false;
			$response["User_ID"] = $User_ID;
    		$response["User_PW"] = $User_PW;
    		$response["User_Name"] = $User_Name;
    		$response["User_Email"] = $User_Email;
    		$response["User_Birthday"] = $User_Birthday;
			$response["User_Type"] = $User_Type;
		} 
	}else{
		$response["response"] = false;
		$response["User_ID"] = $User_ID;
    	$response["User_PW"] = $User_PW;
    	$response["User_Name"] = $User_Name;
    	$response["User_Email"] = $User_Email;
    	$response["User_Birthday"] = $User_Birthday;
		$response["User_Type"] = $User_Type;
	}

    echo json_encode($response);
?>