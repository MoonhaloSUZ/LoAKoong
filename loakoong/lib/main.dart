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
  String userInput = '';

  final sendController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  sendUserName() {
    widget.userName = sendController.text;
    Future<LoAKoongModel> loakoong;

    loakoong = LostArkAPI.getCharacterProfile(widget.userName);
  }

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
                  Text(userInput),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: sendController,
                            onChanged: (text) {
                              setState(() {
                                userInput = text;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: '로아쿵',
                              hintText: '캐릭터명',
                              labelStyle:
                                  TextStyle(color: Colors.deepPurpleAccent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 12, color: Colors.deepPurpleAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    width: 12, color: Colors.deepPurpleAccent),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: sendUserName,
                          child: const Text('확인'),
                        )
                      ],
                    ),
                  ),
                  // FutureBuilder(
                  //   future: sendUserName(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return profileColumn(snapshot);
                  //     } else if (snapshot.hasError) {
                  //       return Text("${snapshot.error}에러!!");
                  //     }
                  //     return const CircularProgressIndicator();
                  //   },
                  // )
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
      Text('캐릭터명:${snapshot.data!.CharacterName}',
          style: const TextStyle(fontSize: 20)),
    ],
  );
}
