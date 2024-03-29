import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loakoong/api/api_service.dart';
import 'screen/character_choice_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  // 초기 사용자 이름 설정
  runApp(const LoAKoongApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}

class LoAKoongApp extends StatelessWidget {
  const LoAKoongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoAKoongScreen(
        userName: '',
      ),
    );
  }
}

class LoAKoongScreen extends StatefulWidget {
  late String userName;

  LoAKoongScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  State<LoAKoongScreen> createState() => _LoAKoongScreenState();
}

class _LoAKoongScreenState extends State<LoAKoongScreen> {
  late Future<List<dynamic>> loakoong = LostArkAPI.getCharacterProfile('');
  late List<bool> _select_character_list;

  List<int> selectValue = []; //스위치 리스트에서 ture값인 인덱스 추출
  List<String> searchedCharacter = []; //각 인덱스의 캐릭터 명(다음 페이지에 넘겨줄 역할)

  String userInput = '';
  bool isSearched = false;
  String printtest = '';

  final sendController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _select_character_list = List.filled(50, false); //야매
  }

//스위치 리스트에서 선택된(ture인) 인덱스 값 추출하기
  selectedList() {
    for (int i = 0; i < _select_character_list.length; i++) {
      if (_select_character_list[i] == true) {
        selectValue.add(i);
      }
    }

    if (selectValue.isNotEmpty) {
      print("true의 모든 등장 위치는 $selectValue 입니다.");
    } else {
      print("true를 찾을 수 없습니다.");
    }
  }

  // sendUserName() async {
  //   if (sendController.text.isEmpty) {
  //     return;
  //   } else {
  //     String userNametest = sendController.text;
  //     if (isSearched == false) {
  //       loakoong = LostArkAPI.getCharacterProfile(userNametest);

  //       setState(() {
  //         isSearched = true;
  //       });
  //     }

  //     return;
  //   }
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'LoAKoong',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 50,
                          child: TextField(
                            controller: sendController,
                            onChanged: (text) {
                              setState(() {
                                userInput = text;
                              });
                            },
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              labelText: '로아쿵',
                              hintText: '닉네임',
                              labelStyle:
                                  TextStyle(color: Colors.deepPurpleAccent),
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black38,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.deepPurpleAccent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        // ElevatedButton(
                        //   onPressed: sendUserName,
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.deepPurpleAccent,
                        //     fixedSize: const Size.square(48),
                        //   ),
                        //   child: const Text('검색'),
                        // )
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              loakoong =
                                  LostArkAPI.getCharacterProfile(userInput);
                              _select_character_list = List.filled(50,
                                  false); //야매222, 캐릭터가 선택되면 선택된 스위치 리스트가 초기화되도록
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            fixedSize: const Size.square(48),
                          ),
                          child: const Text('검색'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.pink.shade300,
                      ),
                    ),
                    margin: const EdgeInsets.all(20),
                    //width: 150,
                    //height: 30,
                    child: FutureBuilder<List<dynamic>>(
                      future: loakoong,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data ?? [];
                          //return Text('데이터 로드 성공: $data');
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return SwitchListTile(
                                title: Text(
                                  data[index].toString(),
                                ),
                                value: _select_character_list[index],
                                onChanged: (value) {
                                  setState(() {
                                    _select_character_list[index] = value;
                                  });
                                },
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Text('캐릭터를 검색해주세요');
                        }
                        // 데이터 로딩 중인 경우 표시할 위젯
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          selectedList();
                          //새로운 사실을 알았다. onPressed 안에 함수를 순차적으로 실행시킬 수 있음.
                          print(selectValue);
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ScreenOfCharacterChoice(
                                    selectValue: selectValue,
                                  ),
                                ),
                              )
                              .then((result) => selectValue = []);
                        },
                        child: const Text("선택완료"),
                      ),
                    ],
                  ),
                  Text(printtest),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget profileColumn(snapshot) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text('$snapshot', style: const TextStyle(fontSize: 20)),
    ],
  );
}
