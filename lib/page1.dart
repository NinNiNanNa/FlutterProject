import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';


class Page1 extends StatefulWidget {

  /*
  main.dart에서 전달한 파라미터를 받기 위해 멤버변수를 선언한 후 생성자에 추가한다.
  또한 required가 있으므로 필수로 받아야하는 값으로 선언된다.
  */
  String data = '';
  // Page1({ Key? key, required this.data}) : super(key: key);
  Page1({super.key, required this.data});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  // 텍스트 음성 변환을 위해 인스턴스생성
  final FlutterTts tts = FlutterTts();
  // 입력 텍스트를 위해 인스턴스생성
  final textEditingController = TextEditingController();
  
  String from = 'ko';               // 원본 언어코드
  String to = 'en';                 // 번역 언어코드
  String selectedvalue = '한국어';  //  from의 드롭다운 메뉴에서 선택된 언어를 나타냄
  String selectedvalue2 = '영어';   //  to의 드롭다운 메뉴에서 선택된 언어를 나타냄
  String translationResult = "";    // 번역 결과
  // 사용 가능한 언어
  List<String> languages = [
    '한국어',
    '영어',
    '독일어',
    '러시아어',
    '스페인어',
    '일본어',
    '중국어(간체)',
    '중국어(번체)',
  ];
  // 사용 가능한 언어의 코드
  List<String> languagescode = [
    'ko',
    'en',
    'de',
    'ru',
    'es',
    'ja',
    'zh-CN',
    'zh-TW'
  ];

  Future<void> getTranslation_papago() async {
    // API 엑세스 권한을 부여받기 위한 클라이언트ID와 시크릿 Key
    // String _client_id = "9MajDt60tH6YlH9PV3MH";
    // String _client_secret = "3XEd9SIe0m";
    String _client_id = "LSFLVTawnX8kO34omNJE";
    String _client_secret = "vTncWwxHlD";
    // HTTP 요청의 컨텐츠 타입
    String _content_type = "application/x-www-form-urlencoded; charset=UTF-8";
    // 요청 URL
    String _url = "https://openapi.naver.com/v1/papago/n2mt";

    /* 
    HTTP POST 요청
    요청 헤더 - 클라이언트ID, 시크릿 Key
    요청 본문 - 원본 언어코드, 번역 언어코드, 입력한(번역할) 텍스트(1회 호출시 최대 5,000자까지 번역)
     */
    http.Response trans = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': _content_type,
        'X-Naver-Client-Id': _client_id,
        'X-Naver-Client-Secret': _client_secret
      },
      body: {
        'source': from,
        'target': to,
        'text': textEditingController.text,
      },
    );
    // HTTP 응답의 상태 코드를 확인해 요청이 성공했는지 검사(성공코드: 200)
    if (trans.statusCode == 200) {
      // 요청 성공시 응답본문을 JSON형식으로 파싱
      var dataJson = jsonDecode(trans.body);
      // print(dataJson);
      // 번역된 텍스트 추출 후 result_papago변수에 저장
      var result_papago = dataJson['message']['result']['translatedText'];
      // print(result_papago);

      // 번역된 텍스트를 출력하기위해 setState함수 호출
      setState(() {
        translationResult = result_papago;
      });
    } else {
      // 요청 실패시 오류 상태코드 출력
      print("번역실패 : ${trans.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('입력 번역기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.indigo, style: BorderStyle.solid, width: 2)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectedvalue,
                        focusColor: Colors.transparent,
                        items: languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(lang),
                            onTap: () {
                              if (lang == languages[0]) {
                                from = languagescode[0];
                              } else if (lang == languages[1]) {
                                from = languagescode[1];
                              } else if (lang == languages[2]) {
                                from = languagescode[2];
                              } else if (lang == languages[3]) {
                                from = languagescode[3];
                              } else if (lang == languages[4]) {
                                from = languagescode[4];
                              } else if (lang == languages[5]) {
                                from = languagescode[5];
                              } else if (lang == languages[6]) {
                                from = languagescode[6];
                              }
                              setState(() {
                                // print(lang);
                                // print(from);
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedvalue = value!;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 30.0,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.indigo, style: BorderStyle.solid, width: 2)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectedvalue2,
                        focusColor: Colors.transparent,
                        items: languages.map((lang) {
                          return DropdownMenuItem(
                            value: lang,
                            child: Text(lang),
                            onTap: () {
                              if (lang == languages[0]) {
                                to = languagescode[0];
                              } else if (lang == languages[1]) {
                                to = languagescode[1];
                              } else if (lang == languages[2]) {
                                to = languagescode[2];
                              } else if (lang == languages[3]) {
                                to = languagescode[3];
                              } else if (lang == languages[4]) {
                                to = languagescode[4];
                              } else if (lang == languages[5]) {
                                to = languagescode[5];
                              } else if (lang == languages[6]) {
                                to = languagescode[6];
                              } else if (lang == languages[7]) {
                                to = languagescode[7];
                              } else if (lang == languages[8]) {
                                to = languagescode[8];
                              }
                              setState(() {
                                // print(lang);
                                // print(from);
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedvalue2 = value!;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 250,
                color: Colors.grey[200],
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(15),
                child: TextField(
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(labelText: '번역할 텍스트 입력', border: InputBorder.none),
                ),
              ),
              SizedBox(height: 16.0,),
              ElevatedButton(
                onPressed: getTranslation_papago,
                child: Text('번역'),
              ),
              SizedBox(height: 16.0,),
              Container(
                height: 250,
                color: Colors.grey[200],
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('번역 결과', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                    Text('$translationResult', style: TextStyle(fontSize: 16)),
                    TextButton(
                      onPressed: () {
                        // 번역될 언어코드로 설정
                        tts.setLanguage(to);
                        // 말하기 속도 설정
                        tts.setSpeechRate(0.5);
                        // tts 실행
                        tts.speak(translationResult);
                        // print('음성텍스트결과 : $translationResult');
                        // print('음성언어결과 : $to');
                      },
                      child: Icon(Icons.volume_up_rounded, size: 20.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
