import 'dart:convert';
import 'dart:io';

import 'package:crud_flutter/list_data.dart';
import 'package:crud_flutter/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({super.key});
  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final namaController = TextEditingController();
  final kedudukanController = TextEditingController();

  Future postData(String nama, String kedudukan) async {
    String url = Platform.isAndroid
      ? 'http://172.20.10.3/PemrogramanMobile/latihan/index.php'
      : 'http://localhost/belajarflutter/index.php';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    String jsonBody = '{"nama": "$nama", "kedudukan": "$kedudukan"}';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Data Anggota'),
      ),
      drawer: const SideMenu(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: namaController,
              decoration: InputDecoration(
                  labelText: 'Nama',
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
              controller: kedudukanController,
              decoration: InputDecoration(
                  labelText: 'kedudukan',
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
                String nama = namaController.text;
                String kedudukan = kedudukanController.text;
                // print(nama);
                postData(nama, kedudukan).then((result) {
                  //print(result['pesan']);
                  if (result['pesan'] == 'berhasil') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          //var namauser2 = namauser;
                          return AlertDialog(
                            title: const Text('Data berhasil di tambah'),
                            content: const Text('ok'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ListData(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        });
                  }
                  setState(() {});
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
