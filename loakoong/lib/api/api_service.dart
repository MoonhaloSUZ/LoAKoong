import 'dart:convert';

import 'auth.dart';
import 'package:http/http.dart' as http;

class LostArkAPI {
  static Future<List> getCharacterProfile(String userName) async {
    const isSearched = false;

    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': 'bearer $loaAuth',
    };

    var loaurl = 'https://developer-lostark.game.onstove.com';
    final url = Uri.parse("$loaurl/characters/$userName/siblings");
    final response = await http.get(url, headers: header);
    //final responsebody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final responsebody = jsonDecode(response.body) as List<dynamic>;
      //예외사항 : statusCode 200이 들어오더라도, jsonDecode(response.body)에 Null값이 들어올 수 있음

      responsebody.sort((a, b) => b['ItemMaxLevel']
          .replaceAll(',', '')
          .compareTo(a['ItemMaxLevel'].replaceAll(',', '')));

      final characterNames =
          responsebody.map((item) => item['CharacterName']).toList();

      print(responsebody);
      print(characterNames);

      return characterNames;
    } else {
      throw Exception('오오~류');
    }
  }

  static Future<List> getCharacterLevel(String userName) async {
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': 'bearer $loaAuth',
    };

    var loaurl = 'https://developer-lostark.game.onstove.com';
    final url = Uri.parse("$loaurl/characters/$userName/siblings");
    final response = await http.get(url, headers: header);
    //final responsebody = jsonDecode(response.body);

    final responsebody = jsonDecode(response.body) as List<dynamic>;

    if (response.statusCode == 200) {
      //예외사항 : statusCode 200이 들어오더라도, jsonDecode(response.body)에 Null값이 들어올 수 있음

      responsebody.sort((a, b) => b['ItemMaxLevel']
          .replaceAll(',', '')
          .compareTo(a['ItemMaxLevel'].replaceAll(',', '')));

      final characterLevels =
          responsebody.map((item) => item['ItemMaxLevel']).toList();

      // print(responsebody);
      // print(characterNames);
      print(characterLevels);

      return characterLevels;
    } else {
      throw Exception('오오~류');
    }
  }
}
