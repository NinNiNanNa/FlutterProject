import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:convert';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  final FlutterTts tts = FlutterTts();
  final textEditingController = TextEditingController();
  
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

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

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
        'text': textEditingController.text,
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
        appBar: AppBar(title: const Text("이미지 번역기")),
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
              _isBusy == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 250,
                color: Colors.grey[200],
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  // maxLines: MediaQuery.of(context).size.height.toInt(),
                  maxLines: null,
                  controller: textEditingController,
                  decoration:
                      const InputDecoration(labelText: '번역할 텍스트', border: InputBorder.none),
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
                        tts.setLanguage(to);
                        tts.setSpeechRate(0.5);
                        tts.speak(translationResult);
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

  // 이미지에서 텍스트를 인식하고 해당 텍스트를 사용자에게 표시하는 역할
  void processImage(InputImage image) async {
    // 텍스트 인식을 위해 인스턴스 생성 (라틴 문자를 스크립트로 설정)
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    // 추출한 텍스트 recognizedText 에 저장
    final RecognizedText recognizedText =
        // 이미지에서 텍스트를 인식하고 추출
        await textRecognizer.processImage(image);

    // 이미지에서 추출한 텍스트를 textEditingController에 설정
    textEditingController.text = recognizedText.text;

    // _isBusy를 false로 설정하여 작업이 완료되었음을 알림
    setState(() {
      _isBusy = false;
    });
  }
}