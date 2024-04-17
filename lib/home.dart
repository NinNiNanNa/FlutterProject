import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_translator/Screen/recognization_page.dart';
import 'package:project_translator/Utils/image_cropper_page.dart';
import 'package:project_translator/Utils/image_picker_class.dart';
import 'package:project_translator/Widgets/modal_dialog.dart';


class Home extends StatefulWidget {

  /*
  main.dart에서 전달한 파라미터를 받기 위해 멤버변수를 선언한 후 생성자에 추가한다.
  또한 required가 있으므로 필수로 받아야하는 값으로 선언된다.
  */
  String data = '';
  Home({super.key, required this.data});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background2.jpg"), fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('SJ 번역기'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(63, 81, 181, .7)),
                      child: const Column(
                        children: [
                          SizedBox(height: 35.0,),
                          Icon(Icons.keyboard_alt_outlined, size: 40.0),
                          SizedBox(height: 15.0,),
                          Text("입력번역", style: TextStyle(fontSize: 15.0),),
                          SizedBox(height: 35.0,),
                        ],
                      ),
                      onPressed: () async {
                        var result = await Navigator.pushNamed(context, '/page1');
                      },
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(63, 81, 181, .7)),
                      child: const Column(
                        children: [
                          SizedBox(height: 35.0,),
                          Icon(Icons.mic_none, size: 40.0),
                          SizedBox(height: 15.0,),
                          Text("음성번역", style: TextStyle(fontSize: 15.0),),
                          SizedBox(height: 35.0,),
                        ],
                      ),
                      onPressed: () async {
                        var result = await Navigator.pushNamed(context, '/page2');
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(63, 81, 181, .7)),
                      child: const Column(
                        children: [
                          SizedBox(height: 35.0,),
                          Icon(Icons.photo_outlined, size: 40.0),
                          SizedBox(height: 15.0,),
                          Text("이미지 번역", style: TextStyle(fontSize: 15.0),),
                          SizedBox(height: 35.0,),
                        ],
                      ),
                      onPressed: () {
                        imagePickerModal(context, onCameraTap: () {
                          log("카메라");
                          pickImage(source: ImageSource.camera).then((value) {
                            if (value != '') {
                              imageCropperView(value, context).then((value) {
                                if (value != '') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => RecognizePage(
                                        path: value,
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          });
                        }, onGalleryTap: () {
                          log("갤러리");
                          pickImage(source: ImageSource.gallery).then((value) {
                            if (value != '') {
                              imageCropperView(value, context).then((value) {
                                if (value != '') {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => RecognizePage(
                                        path: value,
                                      ),
                                    ),
                                  );
                                }
                              });
                            }
                          });
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(63, 81, 181, .7)),
                      child: const Column(
                        children: [
                          SizedBox(height: 35.0,),
                          Icon(Icons.library_books_outlined, size: 40.0),
                          SizedBox(height: 15.0,),
                          Text("단어장", style: TextStyle(fontSize: 15.0),),
                          SizedBox(height: 35.0,),
                        ],
                      ),
                      onPressed: () async {
                        var result = await Navigator.pushNamed(context, '/page3');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
