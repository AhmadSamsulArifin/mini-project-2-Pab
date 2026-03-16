class DataAntrian {
  final int? id;
  final int nomorAntrian;
  final String nama;
  final String nik;
  final String jenisPelayanan;
  final String noHp;
  final String? userId;

  const DataAntrian({
    this.id,
    required this.nomorAntrian,
    required this.nama,
    required this.nik,
    required this.jenisPelayanan,
    required this.noHp,
    this.userId,
  });

  factory DataAntrian.fromMap(Map<String, dynamic> map) {
    final int idData = map['id'] as int;

    return DataAntrian(
      id: idData,
      nomorAntrian: idData,
      nama: map['nama'] ?? '',
      nik: map['nik'] ?? '',
      jenisPelayanan: map['jenis_pelayanan'] ?? '',
      noHp: map['no_hp'] ?? '',
      userId: map['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'nik': nik,
      'jenis_pelayanan': jenisPelayanan,
      'no_hp': noHp,
      'user_id': userId,
    };
  }

  DataAntrian salinDengan({
    int? id,
    int? nomorAntrian,
    String? nama,
    String? nik,
    String? jenisPelayanan,
    String? noHp,
    String? userId,
  }) {
    return DataAntrian(
      id: id ?? this.id,
      nomorAntrian: nomorAntrian ?? this.nomorAntrian,
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      jenisPelayanan: jenisPelayanan ?? this.jenisPelayanan,
      noHp: noHp ?? this.noHp,
      userId: userId ?? this.userId,
    );
  }
}