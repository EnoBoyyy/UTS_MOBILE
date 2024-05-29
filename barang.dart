class Barang{
  String? kode;
  String? nama;
  String? golongan;
  String? satuan;
  int? hargabeli;
  int? hargajual;
  int? diskon;

  barangMap() {
    var mapping = Map<String, dynamic>();
    mapping['kode'] = kode ?? null;
    mapping['nama'] = nama!;
    mapping['golongan'] = golongan!;
    mapping['satuan'] = satuan!;
    mapping['hargabeli'] = hargabeli!;
    mapping['hargajual'] = hargajual!;
    mapping['diskon'] = diskon!;
    return mapping;
  }
}