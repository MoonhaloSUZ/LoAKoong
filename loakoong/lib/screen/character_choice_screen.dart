import 'package:flutter/material.dart';
//import 'package:loakoong/main.dart';

class ScreenOfCharacterChoice extends StatelessWidget {
  const ScreenOfCharacterChoice({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      //제스쳐로 뒤로가기 막기 위해서 "WillPopScope"위젯으로 Scaffold를 감싸준 후, "onWillPop: () async => false" 추가
      child: Scaffold(
          body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("캐릭터 다시 선택"),
        ),
      )),
    );
  }
}
