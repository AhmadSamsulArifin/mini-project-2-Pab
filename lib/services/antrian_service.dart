import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/data_antrian.dart';

class AntrianService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<DataAntrian>> ambilSemuaAntrian() async {
    final response = await _supabase
        .from('antrian')
        .select()
        .order('id', ascending: true);

    return (response as List)
        .map((item) => DataAntrian.fromMap(item))
        .toList();
  }

  Future<void> tambahAntrian(DataAntrian data) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User belum login');
    }

    await _supabase.from('antrian').insert(
          data.salinDengan(userId: user.id).toMap(),
        );
  }

  Future<void> ubahAntrian(DataAntrian data) async {
    await _supabase
        .from('antrian')
        .update(data.toMap())
        .eq('id', data.id as Object);
  }

  Future<void> hapusAntrian(int id) async {
    await _supabase.from('antrian').delete().eq('id', id);
  }
}