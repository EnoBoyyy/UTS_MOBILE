import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/barangservice.dart';
import '../model/barang.dart';
class EditBarang extends StatefulWidget{
  final Barang barang;
  const EditBarang({Key? key, required this.barang}) : super(key: key);
  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang>{

  var _namaController = TextEditingController();
  var _golonganController = TextEditingController();
  var _satuanController = TextEditingController();
  var _hargabeliController = TextEditingController();
  var _hargajualController = TextEditingController();
  var _diskonController = TextEditingController();

  bool _validateNama = false;
  bool _validateGolongan = false;
  bool _validateSatuan = false;
  bool _validatehargabeli = false;
  bool _validatehargajual = false;
  bool _validatediskon = false;
  var _barangService=BarangService();
  @override
  void initState() {
    setState(() {
      _namaController.text=widget.barang.nama??'';
      _golonganController.text=widget.barang.golongan??'';
      _satuanController.text=widget.barang.satuan??'';
      _hargabeliController.text=widget.barang.hargabeli.toString()??'';
      _hargajualController.text=widget.barang.hargajual.toString()??'';
      _diskonController.text=widget.barang.diskon.toString()??'';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Edit Barang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EditBarang',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    TextField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Nama',
                          labelText: 'Nama',
                          errorText:
                          _validateNama ? 'Nama Value Can\'t Be Empty' : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),

                    TextField(
                        controller: _golonganController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Golongan',
                          labelText: 'Golongan',
                          errorText:
                          _validateGolongan ? 'Golongan Value Can\'t Be Empty' : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),

                    TextField(
                        controller: _satuanController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Satuan',
                          labelText: 'Satuan',
                          errorText:
                          _validateSatuan ? 'Satuan Value Can\'t Be Empty' : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),

                    TextField(
                        controller: _hargabeliController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Harga Beli',
                          labelText: 'Harga Beli',
                          errorText:
                          _validatehargabeli ? 'Harga Beli Value Can\'t Be Empty' : null,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),



                    TextField(
                        controller: _hargajualController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter Harga Jual',
                            labelText: 'Harga Jual',
                            errorText:
                            _validatehargajual ? 'Harga Jual Value Can\'t Be Empty' : null
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),

                    TextField(
                        controller: _diskonController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Enter Diskon',
                            labelText: 'Diskon',
                            errorText:
                            _validatediskon ? 'Diskon Value Can\'t Be Empty' : null
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),

                    Row(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.teal,
                                  textStyle: const TextStyle(fontSize: 15)),
                              onPressed: () async {
                                setState(() {
                                  _namaController.text.isEmpty
                                      ? _validateGolongan = true
                                      : _validateGolongan = false;
                                  _golonganController.text.isEmpty
                                      ? _validateSatuan = true
                                      : _validateSatuan = false;
                                  _satuanController.text.isEmpty
                                      ? _validatehargabeli = true
                                      : _validatehargabeli = false;
                                  _hargabeliController.text.isEmpty
                                      ? _validatehargajual = true
                                      : _validatehargajual = false;
                                  _hargajualController.text.isEmpty
                                      ? _validatediskon = true
                                      : _validatediskon = false;
                                });
                                if (
                                _validateNama == false &&
                                    _validateGolongan == false &&
                                    _validateSatuan == false &&
                                    _validatehargabeli == false &&
                                    _validatehargajual == false &&
                                    _validatediskon == false) {
                                  var _barang = Barang();
                                  _barang.kode = widget.barang.kode ;
                                  _barang.nama = _namaController.text;
                                  _barang.golongan = _namaController.text;
                                  _barang.satuan = _satuanController.text;
                                  _barang.hargabeli = int.parse(_hargabeliController.text);
                                  _barang.hargajual = int.parse(_hargajualController.text);
                                  _barang.diskon = int.parse(_diskonController.text);

                                  var hasil = await _barangService.updateBarang(_barang);
                                  Navigator.pop(context,hasil);
                                }
                              },
                              child: const Text('Update')),
                          const SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, backgroundColor: Colors.red,
                                  textStyle: const TextStyle(fontSize: 15)),
                              onPressed: () {
                                _namaController.text = '';
                                _golonganController.text = '';
                                _satuanController.text = '';
                                _hargabeliController.text = '';
                                _hargajualController.text = '';
                                _diskonController.text = '';
                              },
                              child: const Text('Cancel'))
                        ]
                    )

                  ]
              )
          )
      ),
    );
  }
}