import 'dart:convert';

import 'auth.dart';
import 'package:loakoong/model/loakoong_model.dart';
import 'package:http/http.dart' as http;

class LostArkAPI {
  static Future<LoAKoongModel> getCharacterProfile(String userName) async {
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': 'bearer $loaAuth',
    };

    var loaurl = 'https://developer-lostark.game.onstove.com';

    final url = Uri.parse("$loaurl/characters/$userName/siblings");
    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      // print('sucess');
      // print(jsonDecode(response.body));
      return LoAKoongModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Faild');
    }
  }
}

/////////////////////
class ApiService {
  static const String charactername = 'CharacterName';
  //late String userName;
  static String baseUrl = 'https://developer-lostark.game.onstove.com/';

  static Future<List<LoAKoongModel>> getUserData() async {
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
