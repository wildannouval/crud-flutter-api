import 'dart:convert';
import 'package:crud_flutter/list_data.dart';
import 'package:crud_flutter/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateData extends StatefulWidget {
  final String id;
  final String nama;
  final String jurusan;
  final String url;
  const UpdateData(
      {super.key,
      required this.id,
      required this.nama,
      required this.jurusan,
      required this.url});
  @override
  _UpdateData createState() => _UpdateData(url: url);
}

class _UpdateData extends State<UpdateData> {
  String url;
  _UpdateData({required this.url});
  final _namaController = TextEditingController();
  final _jurusanController = TextEditingController();

  Future<void> updateData(String nama, String jurusan, String id) async {
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(
          <String, String>{'id': id, 'nama': nama, 'jurusan': jurusan}),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ListData(),
        ),
      );
    } else {
      throw Exception('Failed to Update Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit Mahasiswa')),
        drawer: const SideMenu(),
        body: ListView(padding: const EdgeInsets.all(16.0), children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: _namaController,
              decoration: InputDecoration(
                  label: Text(widget.nama),
                  hintText: "Nama...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: _jurusanController,
              decoration: InputDecoration(
                  label: Text(widget.jurusan),
                  hintText: "Jurusan...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    updateData(_namaController.text, _jurusanController.text,
                        widget.id);
                  }))
        ]));
  }
}
