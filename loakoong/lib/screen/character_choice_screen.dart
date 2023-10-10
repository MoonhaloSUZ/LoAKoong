import 'package:flutter/material.dart';
//import 'package:loakoong/main.dart';

class ScreenOfCharacterChoice extends StatelessWidget {
  final selectValue;
  const ScreenOfCharacterChoice({required this.selectValue, super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      //제스쳐로 뒤로가기 막기 위해서 "WillPopScope"위젯으로 Scaffold를 감싸준 후, "onWillPop: () async => false" 추가
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'LoAKoong',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.deepPurple,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context); //뒤로가기
                },
                //color: Colors.purple,
                icon: const Icon(Icons.cached_rounded)),
          ),
          body: Column(
            children: [
              Text(
                '$selectValue',
              ),
            ],
          )),
    );
  }
}
