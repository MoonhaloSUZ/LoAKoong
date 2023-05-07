import 'dart:convert';

import 'package:loakoong/model/loakoong_model.dart';
import 'package:http/http.dart' as http;

class LostArkAPI {
  static Future<LoAKoongModel> getCharacterProfile(String userName) async {
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization':
          'bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IktYMk40TkRDSTJ5NTA5NWpjTWk5TllqY2lyZyIsImtpZCI6IktYMk40TkRDSTJ5NTA5NWpjTWk5TllqY2lyZyJ9.eyJpc3MiOiJodHRwczovL2x1ZHkuZ2FtZS5vbnN0b3ZlLmNvbSIsImF1ZCI6Imh0dHBzOi8vbHVkeS5nYW1lLm9uc3RvdmUuY29tL3Jlc291cmNlcyIsImNsaWVudF9pZCI6IjEwMDAwMDAwMDAwMTUyODIifQ.ECtY6DY8rNorVP7DwuiSYUmqWwm83QN6egHUPI-K2C7PPDJ4YRrpp3DkaxTJCDymLbUcj-Kt1P6ferw6tCE9MUj-gNRVXMjgBBdNCezlT9yqhoiHYjjAT6BvzhfiOdGrxSh6ADExeJcU0Zj8UCAdUzwZAazI49ZmaytHkXR9NDMdHzmPB7MW0SmHKt7EzKnSbiGaOAbr2bEKvHAUSpmsVbbYyqQq3jxN_BhAeMtRWP2SQVHngYxDjeUJ_RqfHR9_BTSDiRokKzClUmn9wiBr9-2hYzvnyBwIpwNM2ziRhJnpMNZqE6R0vFiGxQKP5VMXAeGnisMAW2aggJ25kuIf1Q',
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
