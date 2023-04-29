import 'dart:convert';

import 'package:loakoong/model/loakoong_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String charactername = 'CharacterName';
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';

  static Future<List<LoAKoongModel>> getTodaysToons() async {
    List<LoAKoongModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$charactername');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(LoAKoongModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
