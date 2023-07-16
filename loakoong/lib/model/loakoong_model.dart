class LoAKoongModel {
  final String serverName;
  final String characterName;
  final int characterLevel;
  final String characterClassName;
  final String itemAvgLevel;
  final String itemMaxLevel;

  LoAKoongModel({
    required this.serverName,
    required this.characterName,
    required this.characterLevel,
    required this.characterClassName,
    required this.itemAvgLevel,
    required this.itemMaxLevel,
  });

  factory LoAKoongModel.fromJson(Map<String, dynamic> json) {
    return LoAKoongModel(
      itemMaxLevel: json['ItemMaxLevel'],
      serverName: json['ServerName'],
      characterName: json['CharacterName'],
      characterLevel: json['CharacterLevel'],
      characterClassName: json['CharacterClassName'],
      itemAvgLevel: json['ItemAvgLevel'],
    );
  }

  factory LoAKoongModel.fromList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) {
      throw Exception('Empty response');
    }

    final List<LoAKoongModel> modelList = jsonList.map((jsonData) {
      return LoAKoongModel.fromJson(jsonData);
    }).toList();

    return modelList.first;
  }
}
