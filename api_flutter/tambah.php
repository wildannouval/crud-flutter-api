<?php

if ($method === "POST") {
    //menambah data mahasiswa
    $data = json_decode(file_get_contents("php://input"), true);
    $nama = $data["nama"];
    $jurusan = $data["jurusan"];

    $sql = "INSERT INTO mahasiswa (nama,jurusan) VALUES ('$nama','$jurusan')";
    if ($conn->query($sql) === TRUE) {
        $data['pesan'] = 'berhasil';
        //echo "Berhasil tambah data";
    } else {
        $data['pesan'] = "Error: " . $sql . "<br>" . $conn->error;
    }
    echo json_encode($data);
}