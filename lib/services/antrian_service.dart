import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/data_antrian.dart';

class AntrianService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<DataAntrian>> ambilSemuaAntrian() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final response = await _supabase
        .from('antrian')
        .select()
        .eq('user_id', user.id)
        .order('id', ascending: true);

    return (response as List)
        .map((item) => DataAntrian.fromMap(item))
        .toList();
  }

  Future<void> tambahAntrian(DataAntrian data) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User belum login');

    await _supabase.from('antrian').insert(
          data.salinDengan(userId: user.id).toMap(),
        );
  }

  Future<void> ubahAntrian(DataAntrian data) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User belum login');

    await _supabase
        .from('antrian')
        .update(data.salinDengan(userId: user.id).toMap())
        .eq('id', data.id as Object)
        .eq('user_id', user.id);
  }

  Future<void> hapusAntrian(int id) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User belum login');

    await _supabase
        .from('antrian')
        .delete()
        .eq('id', id)
        .eq('user_id', user.id);
  }
}