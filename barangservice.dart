import '../model/barang.dart';
import '../model/repository.dart';

class BarangService
{
  late Repository _repository;
  BarangService()
  {
    _repository = Repository();
  }
//Save barang
  saveBarang(Barang barang) async{
    return await _repository.insertData('barang', barang.barangMap());
  }
//Read barang
  readAllBarang() async{
    return await _repository.readData('barang');
  }
//Edit User
  updateBarang(Barang barang) async{
    return await _repository.updateData('barang', barang.barangMap());
  }

  deleteBarang(kode) async {
    return await _repository.deleteDataBykode('barang', kode);
  }


}