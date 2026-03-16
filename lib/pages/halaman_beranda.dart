import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/data_antrian.dart';
import '../services/antrian_service.dart';
import 'halaman_detail_antrian.dart';
import 'halaman_form_antrian.dart';

class HalamanBeranda extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggleTheme;

  const HalamanBeranda({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  final AntrianService _service = AntrianService();
  final TextEditingController _cariC = TextEditingController();

  List<DataAntrian> _daftarAntrian = [];
  bool _isLoading = true;
  String _kataKunci = '';

  @override
  void initState() {
    super.initState();
    _ambilData();
  }

  @override
  void dispose() {
    _cariC.dispose();
    super.dispose();
  }

  String _formatNomor(int n) {
    return n.toString().padLeft(3, '0');
  }

  Future<void> _ambilData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final hasil = await _service.ambilSemuaAntrian();
      setState(() {
        _daftarAntrian = hasil;
      });
    } catch (e) {
      _tampilkanPesan('Gagal mengambil data', Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _tampilkanPesan(String pesan, Color warna) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: warna,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<DataAntrian> get _dataTampil {
    if (_kataKunci.isEmpty) return _daftarAntrian;

    final q = _kataKunci.toLowerCase();

    return _daftarAntrian.where((d) {
      return d.nama.toLowerCase().contains(q) ||
          d.nik.contains(_kataKunci) ||
          d.jenisPelayanan.toLowerCase().contains(q) ||
          d.noHp.contains(_kataKunci) ||
          _formatNomor(d.nomorAntrian).contains(_kataKunci);
    }).toList();
  }

  Future<void> _tambahData() async {
    final hasil = await Navigator.push<DataAntrian>(
      context,
      MaterialPageRoute(
        builder: (_) => const HalamanFormAntrian(),
      ),
    );

    if (hasil == null) return;

    try {
      await _service.tambahAntrian(hasil);
      await _ambilData();
      _tampilkanPesan('Data berhasil ditambahkan', Colors.green);
    } catch (e) {
      _tampilkanPesan('Data gagal ditambahkan', Colors.red);
    }
  }

  Future<void> _ubahData(DataAntrian data) async {
    final hasil = await Navigator.push<DataAntrian>(
      context,
      MaterialPageRoute(
        builder: (_) => HalamanFormAntrian(
          dataAwal: data,
        ),
      ),
    );

    if (hasil == null) return;

    try {
      await _service.ubahAntrian(hasil);
      await _ambilData();
      _tampilkanPesan('Data berhasil diubah', Colors.blue);
    } catch (e) {
      _tampilkanPesan('Data gagal diubah', Colors.red);
    }
  }

  void _hapusData(DataAntrian data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              try {
                await _service.hapusAntrian(data.id as int);
                await _ambilData();
                _tampilkanPesan('Data berhasil dihapus', Colors.red);
              } catch (e) {
                _tampilkanPesan('Data gagal dihapus', Colors.red);
              }
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await Supabase.instance.client.auth.signOut();
  }

  void _bukaDetail(DataAntrian data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HalamanDetailAntrian(data: data),
      ),
    );
  }

  Widget _panelAtas() {
    final user = Supabase.instance.client.auth.currentUser;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat datang,',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? 'Pengguna',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _cariC,
                  decoration: InputDecoration(
                    hintText: 'Cari nama, NIK, pelayanan, nomor...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _kataKunci.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _cariC.clear();
                              setState(() {
                                _kataKunci = '';
                              });
                            },
                          ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _kataKunci = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _kartuInfo(
                  ikon: Icons.groups,
                  judul: 'Total Antrian',
                  nilai: '${_daftarAntrian.length}',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _kartuInfo(
                  ikon: Icons.list_alt,
                  judul: 'Data Tampil',
                  nilai: '${_dataTampil.length}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kartuInfo({
    required IconData ikon,
    required String judul,
    required String nilai,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                ikon,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    nilai,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tampilanKosong() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.inbox_outlined,
                  size: 60,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Belum ada data antrian',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tekan tombol tambah untuk memasukkan data antrian.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemAntrian(DataAntrian data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          leading: Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              _formatNomor(data.nomorAntrian),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          title: Text(
            data.nama,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pelayanan: ${data.jenisPelayanan}'),
                const SizedBox(height: 4),
                Text('No HP: ${data.noHp}'),
              ],
            ),
          ),
          isThreeLine: true,
          trailing: Wrap(
            spacing: 4,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _ubahData(data),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _hapusData(data),
              ),
            ],
          ),
          onTap: () => _bukaDetail(data),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataTampil = _dataTampil;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrian Kecamatan'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _ambilData,
            icon: const Icon(Icons.refresh),
          ),
          Row(
            children: [
              const Icon(Icons.dark_mode, size: 20),
              Switch(
                value: widget.isDarkMode,
                onChanged: widget.onToggleTheme,
              ),
            ],
          ),
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
          const SizedBox(width: 6),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahData,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: Column(
        children: [
          _panelAtas(),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _daftarAntrian.isEmpty
                    ? _tampilanKosong()
                    : dataTampil.isEmpty
                        ? const Center(
                            child: Text(
                              'Data tidak ditemukan.\nCoba kata kunci lain.',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _ambilData,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 90),
                              itemCount: dataTampil.length,
                              itemBuilder: (context, index) {
                                final data = dataTampil[index];
                                return _itemAntrian(data);
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}