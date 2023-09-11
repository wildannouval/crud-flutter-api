<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

//koneksi ke database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "belajar_api";

$conn = new mysqli($servername, $username, $password, $dbname);

if($conn->connect_error){
die("Koneksi ke databse gagal: ".$conn->connect_error);
}