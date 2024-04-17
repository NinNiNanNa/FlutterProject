import 'package:flutter/material.dart';
import 'package:project_translator/page2.dart';
import 'home.dart';
import 'page1.dart';
import 'page2.dart';
import 'page3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // Route 사용시 시작 페이지를 지정하는 프로퍼티
      initialRoute: '/home',
      routes: {
        /*
        각 페이지를 Map으로 설정한다.
        페이지를 사용할때 data라는 파라미터를 전달한다.
        */
        '/home': (context) => Home(data: ''),
        '/page1': (context) => Page1(data: ''),
        '/page2': (context) => Page2(data: ''),
        '/page3': (context) => Page3(data: ''),
      },
    );
  }
}