import 'package:flutter/material.dart';

class ScreenOfCharacterChoice extends StatefulWidget {
  final List<int> selectValue;
  final Future<List<dynamic>> loakoong;

  const ScreenOfCharacterChoice(
      {required this.selectValue, required this.loakoong, super.key});

  @override
  State<ScreenOfCharacterChoice> createState() =>
      _ScreenOfCharacterChoiceState();
}

class _ScreenOfCharacterChoiceState extends State<ScreenOfCharacterChoice> {
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '선택된 토글 인덱스는 ${widget.selectValue}입니다',
                ),

                ///*********************************///
                FutureBuilder<List<dynamic>>(
                  future: widget.loakoong,
                  //loakoong에 저장된 값은 메인 페이지에서 설정한 캐릭터 이름 값임(String 형식이 아님 Instance of'Future<list<dynamic>>'임)
                  //
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data ?? [];
                      //return Text('데이터 로드 성공: $data');
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: widget.selectValue.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 100,
                            //color: Colors.amber,
                            child: Center(
                                child: Text(
                              ' ${data[widget.selectValue[index]]}',
                            )),
                          );
                        },

                        //최상단과 최하단에 구분선을 추가하는 것부터 시작~
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Colors.deepPurple,
                          indent: 22,
                          endIndent: 22,
                        ),
                      );
                    }
                    // 데이터 로딩 중인 경우 표시할 위젯
                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          )),
    );
  }
}
