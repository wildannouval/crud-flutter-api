import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crud_flutter/side_menu.dart';
import 'package:crud_flutter/tambah_data.dart';
import 'package:crud_flutter/update_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListData extends StatefulWidget {
  const ListData({super.key});
  @override
// ignore: library_private_types_in_public_api
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  List<Map<String, String>> dataAnggota = [];
  String url = Platform.isAndroid
      ? 'http://172.20.10.3/PemrogramanMobile/latihan/index.php'
      : 'http://localhost/PemrogramanMobile/latihan/index.php';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        dataAnggota = List<Map<String, String>>.from(data.map((item) {
          return {
            'nama': item['nama'] as String,
            'kedudukan': item['kedudukan'] as String,
            'id': item['id'] as String,
          };
        }));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future deleteData(int id) async {
    final response = await http.delete(Uri.parse('$url?id=$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  lihatAnggota(String id, String nama, String kedudukan) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Detail Anggota'),
            content: Container(
              height: 100.0,
              width: 400.0,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    child: Text('Id : $id'),
                  ),
                  Container(
                    child: Text('Nama : $nama'),
                  ),
                  Container(
                    child: Text('Kedudukan : $kedudukan'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Anggota Kelompok'),
      ),
      drawer: const SideMenu(),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const TambahData()),
                  ));
            },
            child: const Text('Tambah Data Anggota Kelompok'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataAnggota.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataAnggota[index]['nama']!),
                  subtitle: Text('Kedudukan: ${dataAnggota[index]['kedudukan']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          lihatAnggota(
                              dataAnggota[index]['id']!,
                              dataAnggota[index]['nama']!,
                              dataAnggota[index]['kedudukan']!);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => UpdateData(
                                    id: dataAnggota[index]['id']!,
                                    nama: dataAnggota[index]['nama']!,
                                    kedudukan: dataAnggota[index]['kedudukan']!,
                                    url: url)),
                              ));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteData(int.parse(dataAnggota[index]['id']!))
                              .then((result) {
                            if (result['pesan'] == 'berhasil') {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          const Text('Data berhasil di hapus'),
                                      content: const Text('ok'),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ListData(),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
