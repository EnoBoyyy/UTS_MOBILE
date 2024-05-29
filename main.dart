import 'package:flutter/material.dart';
import 'package:sqlflutter/controller/barangservice.dart';
import 'package:sqlflutter/view/Addbarang.dart';
import 'package:sqlflutter/view/Editbarang.dart';
import 'package:sqlflutter/view/Viewbarang.dart';
import 'model/barang.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Barang> _barangList = <Barang>[];
  late final _barangService = BarangService();

  getAllBarang() async{
    var barangs = await _barangService.readAllBarang();
    _barangList = <Barang>[];
    barangs.forEach((barang){
      setState(() {
        var barangModel = Barang();
        barangModel.kode = barang['kode'];
        barangModel.nama = barang['nama'];
        barangModel.golongan = barang['golongan'];
        barangModel.satuan = barang['satuan'];
        barangModel.hargabeli = barang['hargabeli'];
        barangModel.hargajual = barang['hargajual'];
        barangModel.diskon = barang['diskon'];
        _barangList.add(barangModel);
      });
    });

  }
  @override
  void initState() {
    getAllBarang();
    super.initState();
  }
  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, kode) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Kamu Yakin Menghapus',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red),
                  onPressed: () async{
                    var result=await _barangService.deleteBarang(kode);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllBarang();
                      _showSuccessSnackBar(
                          'Hapus Data Barang Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Barang'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _barangList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          ViewBarang(barang: _barangList[index],
                          ))).
                  then((data) {
                    if (data != null) {
                      getAllBarang();
                      _showSuccessSnackBar('Tambah Data Barang Success');
                    }
                  });
                },
                leading: const Icon(Icons.shopping_cart),
                iconColor: Colors.purple,
                title: Text(_barangList[index].kode.toString() ?? ''),
                subtitle: Text(_barangList[index].nama ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  EditBarang(barang: _barangList[index],)))
                              .then((data) {
                            if (data != null) {
                              getAllBarang();
                              _showSuccessSnackBar(
                                  'Data Barang Updated Success');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, _barangList[index].kode);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBarang()))
              .then((data) {
            if (data != null) {
              getAllBarang();
              _showSuccessSnackBar('Tambah Data Barang Success');
            }
          });
        },
        child:
        const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}