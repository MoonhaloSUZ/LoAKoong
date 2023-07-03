import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loakoong/api/api_service.dart';
import 'package:loakoong/model/loakoong_model.dart';

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
  late Future<LoAKoongModel> loakoong;

  String userInput = '';
  bool isSearched = false;
  String printtest = '';

  final sendController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loakoong = LostArkAPI.getCharacterProfile('달구룽');
  }

  // sendUserName() async {
  //   if (sendController.text.isEmpty) {
  //     return;
  //   } else {
  //     String userNametest = sendController.text;

  //     LoAKoongModel characterNameData =
  //         await LostArkAPI.getCharacterProfile(userNametest);

  //     setState(() {
  //       printtest = characterNameData.characterName;
  //       isSearched = true;
  //     });

  //     print(characterNameData.toString());

  //     return characterNameData;
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
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
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
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: const Text('List'),
                                    content: SingleChildScrollView(
                                      child: FutureBuilder(
                                        future: loakoong,
                                        builder: ((context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data!.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                ]);
                                          }
                                          return const Text("캐릭터를 조회할 수 없어요");
                                        }),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            // your code
                                          })
                                    ],
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            fixedSize: const Size.square(48),
                          ),
                          child: const Text('검색'),
                        )
                      ],
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
