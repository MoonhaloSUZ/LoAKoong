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
    //final responsebody = jsonDecode(response.body);

    final responsebody = jsonDecode(response.body) as List<dynamic>;

    if (response.statusCode == 200) {
      //예외사항 : statusCode 200이 들어오더라도, jsonDecode(response.body)에 Null값이 들어올 수 있음

      if (responsebody != null) {
        // responsebody
        //     .sort((a, b) => b['ItemMaxLevel'].compareTo(a['ItemMaxLevel']));
        responsebody.sort((a, b) => b['ItemMaxLevel']
            .replaceAll(',', '')
            .compareTo(a['ItemMaxLevel'].replaceAll(',', '')));

        final characterNames =
            responsebody.map((item) => item['CharacterName']).toList();

        print(responsebody);

        return LoAKoongModel.fromList(responsebody);
      } else {
        return LoAKoongModel(
            serverName: '캐릭터를 찾을 수 없어요 Ooㅠ_ㅠoO',
            characterName: '캐릭터를 찾을 수 없어요 Ooㅠ_ㅠoO',
            characterLevel: 0,
            characterClassName: '캐릭터를 찾을 수 없어요 Ooㅠ_ㅠoO',
            itemAvgLevel: '캐릭터를 찾을 수 없어요 Ooㅠ_ㅠoO',
            itemMaxLevel: '캐릭터를 찾을 수 없어요 Ooㅠ_ㅠoO');
      }
    } else {
      throw Exception('오오~류');
    }
  }
}
