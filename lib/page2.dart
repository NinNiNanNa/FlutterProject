import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';

class Page2 extends StatefulWidget {
  
  String data = '';
  Page2({ Key? key, required this.data}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  // 음성 인식을 위해 인스턴스 생성
  SpeechToText speechToText = SpeechToText();
  // 인식된 텍스트 저장할 변수
  var text = "";
  // 현재 음성 인식이 활성화되어 있는지 여부
  var isListening = false;

  final FlutterTts tts = FlutterTts();
  
  String from = 'ko';
  String to = 'en';
  String selectedvalue = '한국어';
  String selectedvalue2 = '영어';
  String translationResult = "";
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
    // String _client_id = "9MajDt60tH6YlH9PV3MH";
    // String _client_secret = "3XEd9SIe0m";
    String _client_id = "LSFLVTawnX8kO34omNJE";
    String _client_secret = "vTncWwxHlD";
    String _content_type = "application/x-www-form-urlencoded; charset=UTF-8";
    String _url = "https://openapi.naver.com/v1/papago/n2mt";

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
        'text': text,
      },
    );
    if (trans.statusCode == 200) {
      var dataJson = jsonDecode(trans.body);
      // print(dataJson);
      var result_papago = dataJson['message']['result']['translatedText'];
      // print(result_papago);
      setState(() {
        translationResult = result_papago;
      });
    } else {
      print("번역실패 : ${trans.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('음성 번역기'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Row(
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
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black12, width: 0),
              color: Colors.grey[200],
            ),
            height: 220,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            child: Text(text, style: TextStyle(
                                fontSize: 20,
                                color: isListening ? Colors.black87 : Colors.black54, fontWeight: isListening ? FontWeight.normal : FontWeight.bold),),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: ElevatedButton(
              onPressed: getTranslation_papago,
              child: Text('번역'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black12, width: 0),
              color: Colors.grey[200],
            ),
            height: 220,
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text('$translationResult', style: TextStyle(fontSize: 20)),
                TextButton(
                  onPressed: () {
                    // 번역될 언어코드로 설정
                    tts.setLanguage(to);
                    // 말하기 속도 설정
                    tts.setSpeechRate(0.5);
                    // tts 실행
                    tts.speak(translationResult);
                  },
                  child: Icon(Icons.volume_up_rounded, size: 20.0),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 55.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: Colors.indigo,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTap: () async {
            // 현재 음성 인식이 활성화되어 있다면
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  // 현재 음성 인식 활성화 여부 true로 변경
                  isListening = true;
                  // SST 실행
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        // 인식된 음성 text 변수에 저장
                        text = result.recognizedWords;
                      });
                    },
                  );
                });
              }
            // 현재 음성 인식이 활성화되어 있지 않다면
            } else if (isListening) {
              setState(() {
                isListening = false;
              });
              // STT 중지
              speechToText.stop();
            }

          },
          child: CircleAvatar(
            backgroundColor: Colors.indigo,
            radius: 35,
            child: Icon(isListening ? Icons.more_horiz : Icons.mic_none, color: Colors.white),
          ),
        ),
      ),
    );
  }

  
}
