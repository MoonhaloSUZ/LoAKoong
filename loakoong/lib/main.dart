import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loakoong/api/api_service.dart';

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
  late Future<List<dynamic>> loakoong = LostArkAPI.getCharacterProfile('달구룽');

  String userInput = '';
  bool isSearched = false;
  String printtest = '';

  bool _toggled = false;

  final sendController = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  // justNothing() {
  //   setState(() {
  //     isSearched = false;
  //   });
  //   return;
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
                    padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
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
                          //지금 필요한 기능 : 캐릭터 선택 버튼(각 리스트 옆에)), 캐릭터 선택 완료 버튼
                          onPressed: () {
                            setState(() {
                              loakoong =
                                  LostArkAPI.getCharacterProfile(userInput);
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '선택완료 버튼',
                      ),
                    ],
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
                                value: _toggled,
                                onChanged: (value) {
                                  setState(() {
                                    _toggled = value;
                                  });
                                },
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('데이터 로드 실패: ${snapshot.error}');
                        }

                        // 데이터 로딩 중인 경우 표시할 위젯
                        return const CircularProgressIndicator();
                      },
                    ),
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
