import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlflutter/controller/barangservice.dart';

import '../model/barang.dart';

class AddBarang extends StatefulWidget {
  @override
  State<AddBarang> createState() => _AddBarangState();
}

class _AddBarangState extends State<AddBarang> {
  var _kodeController = TextEditingController();
  var _namaController = TextEditingController();
  var _golonganController = TextEditingController();
  var _satuanController = TextEditingController();
  var _hargabeliController = TextEditingController();
  var _hargajualController = TextEditingController();
  var _diskonController = TextEditingController();
  bool _validateKode = false;
  bool _validateNama = false;
  bool _validateGolongan = false;
  bool _validateSatuan = false;
  bool _validatehargabeli = false;
  bool _validatehargajual = false;
  bool _validatediskon = false;
  var _barangService = BarangService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Add Barang'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Barang',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _kodeController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Kode',
                  labelText: 'Kode',
                  errorText: _validateKode ? 'Kode Value Can\'t Be Empty' : null,
                ),
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
                  errorText: _validateNama ? 'Nama Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _golonganController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Golongan',
                  labelText: 'Golongan',
                  errorText: _validateGolongan ? 'Golongan Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _satuanController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Satuan',
                  labelText: 'Satuan',
                  errorText: _validateSatuan ? 'Satuan Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _hargabeliController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Harga Beli',
                  labelText: 'Harga Beli',
                  errorText: _validatehargabeli ? 'Harga Beli Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _hargajualController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Harga Jual',
                  labelText: 'Harga Jual',
                  errorText: _validatehargajual ? 'Harga Jual Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              TextField(
                controller: _diskonController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Diskon',
                  labelText: 'Diskon',
                  errorText: _validatediskon ? 'Diskon Value Can\'t Be Empty' : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () async {
                      setState(() {
                        _validateKode = _kodeController.text.isEmpty;
                        _validateNama = _namaController.text.isEmpty;
                        _validateGolongan = _golonganController.text.isEmpty;
                        _validateSatuan = _satuanController.text.isEmpty;
                        _validatehargabeli = _hargabeliController.text.isEmpty;
                        _validatehargajual = _hargajualController.text.isEmpty;
                        _validatediskon = _diskonController.text.isEmpty;
                      });

                      if (!_validateKode &&
                          !_validateNama &&
                          !_validateGolongan &&
                          !_validateSatuan &&
                          !_validatehargabeli &&
                          !_validatehargajual &&
                          !_validatediskon) {

                        var _barang = Barang();
                        _barang.kode = _kodeController.text;
                        _barang.nama = _namaController.text;
                        _barang.golongan = _golonganController.text;
                        _barang.satuan = _satuanController.text;
                        _barang.hargabeli = int.parse(_hargabeliController.text);
                        _barang.hargajual = int.parse(_hargajualController.text);
                        _barang.diskon = int.parse(_diskonController.text);

                        var hasil = await _barangService.saveBarang(_barang);
                        Navigator.pop(context, hasil);
                      }
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      _kodeController.clear();
                      _namaController.clear();
                      _golonganController.clear();
                      _satuanController.clear();
                      _hargabeliController.clear();
                      _hargajualController.clear();
                      _diskonController.clear();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
