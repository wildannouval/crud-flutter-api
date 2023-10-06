import 'dart:convert';
import 'package:crud_flutter/list_data.dart';
import 'package:crud_flutter/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateData extends StatefulWidget {
  final String id;
  final String nama;
  final String kedudukan;
  final String url;
  const UpdateData(
      {super.key,
      required this.id,
      required this.nama,
      required this.kedudukan,
      required this.url});
  @override
  _UpdateData createState() => _UpdateData(url: url);
}

class _UpdateData extends State<UpdateData> {
  String url;
  _UpdateData({required this.url});
  final _namaController = TextEditingController();
  final _kedudukanController = TextEditingController();

  Future<void> updateData(String nama, String kedudukan, String id) async {
    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(
          <String, String>{'id': id, 'nama': nama, 'kedudukan': kedudukan}),
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
        appBar: AppBar(title: const Text('Edit Data Anggota')),
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
              controller: _kedudukanController,
              decoration: InputDecoration(
                  label: Text(widget.kedudukan),
                  hintText: "Kedudukan...",
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
                    updateData(_namaController.text, _kedudukanController.text,
                        widget.id);
                  }))
        ]));
  }
}
