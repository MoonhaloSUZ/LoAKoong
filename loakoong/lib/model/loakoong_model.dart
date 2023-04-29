class LoAKoongModel {
  final String charactername, characterlevel;

  LoAKoongModel.fromJson(Map<String, dynamic> json)
      : charactername = json['CharacterName'],
        characterlevel = json['CharacterLevel'];
  //named constructor 이용
  //api_service.dart 에서 api json 값을 받아오고, 여기서 초기화
}
