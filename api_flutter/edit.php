<?php
if ($method === "PUT") {
    //Memperbarui data mahasiswa
    $data = json_decode(file_get_contents("php://input"), true);
    $id = $data["id"];
    $nama = $data["nama"];
    $jurusan = $data["jurusan"];

    $sql = "UPDATE mahasiswa SET nama='$nama', jurusan='$jurusan' WHERE id=$id";
    if ($conn->query($sql) === TRUE) {
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}