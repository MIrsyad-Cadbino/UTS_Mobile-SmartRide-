import 'dart:math'; //generate angka random untuk pembuatan ID

abstract class Transportasi{
  String id; //untuk identifier
  String nama; // untuk nama transportasi
  double _tarifDasar ; //ini digunakan untuk tarif dasar
  int kapasitas; // untuk jumlah maksimal penumpang 

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas); //konstruktor untuk menisialisasikan object ketika program di mulai

  double hitungTarif(int jumlahPenumpang); //method abstrak yang akan digunakan ke kelas turunan

  void tampilanInfo() => print("Transportasi : $nama");

  double get tarifDasar => _tarifDasar; //ini method getter untuk akses nnilai _tarifDasar agar lebih aman
}

//class turunan dari Class induk
class Taksi extends Transportasi{
  double jarak;

  //konstruktor dari class turunan
  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
  : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jumlahPenumpang *jarak;
  }
}

//class turunan dari Class induk
class Bus extends Transportasi{
  bool adaWifi;


  //konstruktor dari class turunan
  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
  : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    double tambahan = adaWifi ? 5000 : 0;
    return (tarifDasar * jumlahPenumpang) + tambahan;
  }
}

//class turunan dari Class induk
class Pesawat extends Transportasi{
  String tipeKelas;

  //konstruktor dari class turunan
  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.tipeKelas)
  : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    double tipe = (tipeKelas == "Bisni") ? 1.5 : 1.0;
    return tarifDasar * jumlahPenumpang * tipe;
  }
}

class Pemesanan{
  String idPemesanan; //kode unik pemesanan
  String namaPelanggan; // nama pelanggan
  Transportasi transportasi; //objek dari kelas transportasi
  int jumlahPenumpang; // jumlah penumpang
  double totalTarif; // total biaya perjalanan

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi, this.jumlahPenumpang)
   : totalTarif = transportasi.hitungTarif(jumlahPenumpang);

  void cetakStruk(){
    print("==== STRUK PESANAN ====");
    print("kode pesanan   : $idPemesanan");
    print("nama pelanggan : $namaPelanggan");
    print("transportasi   : ${transportasi.nama}");
    print("jumlah pelanggan : $jumlahPenumpang");
    print("Total Biaya   : $totalTarif");
    print("=======================");
    print("");
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : idPemesanan,
      "nama" : namaPelanggan,
      "transportasi" : transportasi,
      "penumpang" : jumlahPenumpang,
      "total" : totalTarif
    };
  }
}

// global func

List<Pemesanan> semuaPesanan = []; //Digunakan untuk menyimpan data pesanan pelanggan

Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang){
  String kode = "ID${Random().nextInt(9999)}"; //penggunaan library dart:math untuk generate kode pesanan
  Pemesanan p = Pemesanan(kode, nama, t, jumlahPenumpang);
  semuaPesanan.add(p);
  return p;
}

void tampilanSemuaPesanan(){
  print("==== List Semua Pesanan Pelanggan");
  for (var p in semuaPesanan){ //setiap p yang ada di data semuaPesanan akan dijadikan data di toMap
    print(p.toMap());
  }
}

void main (){
  var taksi = Taksi("T01", "BlueBeurddddd", 1500, 3, 12);
  var bus = Bus("B01", "BuzzBee", 15000, 10, true);

  var p1 = buatPemesanan(taksi, "Alex", 3);
  var p2 = buatPemesanan(bus, "Agus", 5);

  p1.cetakStruk();
  p2.cetakStruk();

  tampilanSemuaPesanan();
}