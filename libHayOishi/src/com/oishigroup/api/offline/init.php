<?php
$js = $_POST['msg'];

$obj = json_decode($js);
$uid = $obj->uid;

echo '{
  "name": "Chonlatit Wetchasilp", 
  "profile_img": "test.jpg",
  "farm_name": "OishiFarm",
  "first_time": "0",
  "bonus_item": "",
  "coin": "100",
  "fields": {
    "data": [
      {
        "x": "0", 
        "y": "0",
        "value": "001"
      }, 
      {
        "x": "0", 
        "y": "1",
        "value": "002"
      }
    ]
  }
}';
?>