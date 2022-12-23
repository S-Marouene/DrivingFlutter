import 'dart:convert';
import 'package:driving/models/condidats.dart';
// ignore: library_prefixes
import 'package:dio/dio.dart' as Dio;
import '../dio.dart';

class CondidatsApi {
  static Future<List<Condidat>> getCondidats(String query) async {
    Dio.Response response = await dio()
        .get('/allCondidats', options: Dio.Options(headers: {'auth': true}));

    if (response.statusCode == 200) {
      final List condidats = json.decode(response.toString());
      condidats.map((json) => Condidat.fromJson(json)).toList();

      return condidats.map((value) => Condidat.fromJson(value)).where((book) {
        final titleLower = book.nom!.toLowerCase();
        final authorLower = book.prenom!.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
