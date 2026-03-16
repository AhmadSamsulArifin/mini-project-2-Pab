import 'package:flutter/material.dart';
import '../models/data_antrian.dart';

class HalamanDetailAntrian extends StatelessWidget {
  final DataAntrian data;

  const HalamanDetailAntrian({
    super.key,
    required this.data,
  });

  String _formatNomor(int n) {
    return n.toString().padLeft(3, '0');
  }

  Widget _itemDetail({
    required IconData ikon,
    required String judul,
    required String isi,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              ikon,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isi,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nomor = data.nomorAntrian == 0
        ? '-'
        : _formatNomor(data.nomorAntrian);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Antrian'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.confirmation_number,
                            size: 34,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Nomor Antrian',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            nomor,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _itemDetail(
                      ikon: Icons.person,
                      judul: 'Nama',
                      isi: data.nama,
                      context: context,
                    ),
                    _itemDetail(
                      ikon: Icons.credit_card,
                      judul: 'NIK',
                      isi: data.nik,
                      context: context,
                    ),
                    _itemDetail(
                      ikon: Icons.description,
                      judul: 'Jenis Pelayanan',
                      isi: data.jenisPelayanan,
                      context: context,
                    ),
                    _itemDetail(
                      ikon: Icons.phone,
                      judul: 'No HP',
                      isi: data.noHp,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}