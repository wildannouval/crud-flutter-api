<?php

$method = $_SERVER["REQUEST_METHOD"];
if ($method === "GET") {
    //mengambil data mahasiswa
    $sql = "SELECT * FROM mahasiswa";
    $result = $conn->query($sql);

    if ($result->num_rows() > 0) {
        $mahasiswa = array();
        while ($row = $result->fetch_assoc()) {
            $mahasiswa[] = $row;
        }
        echo json_encode($mahasiswa);
    } else {
        echo "Data mahasiswa Kosong";
    }
}