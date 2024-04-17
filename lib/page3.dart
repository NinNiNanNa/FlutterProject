import 'package:flutter/material.dart';
import 'package:project_translator/Widgets/word_item.dart';
import 'package:project_translator/model/word.dart';

class Page3 extends StatefulWidget {
  
  String data = '';
  Page3({ Key? key, required this.data}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final wordsList = Word.wordList();
  List<Word> _foundWord = [];
  final _wordController = TextEditingController();

  @override
  void initState() {
    _foundWord = wordsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text('단어장'),
      ),
      body: Stack(
        children: [
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            padding: EdgeInsets.only(left: 15, right: 15, top:15, bottom: 75),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40, bottom: 20),
                        child: Text('단어 목록', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
                      ),

                      for ( Word word in _foundWord.reversed )
                        WordItem(
                          word: word,
                          onWordChanged: _handleWordChange,
                          onDeleteItem: _deleteWordItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.indigo[50],
              padding: EdgeInsets.only(top: 15),
              child: Row(children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15, right: 15, left: 15),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _wordController,
                      decoration: InputDecoration(
                        hintText: '추가할 단어 입력',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, right: 15),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40),),
                    onPressed: () {
                      // print('추가버튼');
                      _addWordItem(_wordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  // 체크버튼의 완료 or 미완료 상태 토글
  void _handleWordChange(Word word) {
    setState(() {
      word.isDone = !word.isDone;
    });
  }
  // 단어 삭제
  void _deleteWordItem(String id) {
    setState(() {
      wordsList.removeWhere((item) => item.id == id);
    });
  }
  // 새로운 단어를 추가
  void _addWordItem(String word) {
    setState(() {
      wordsList.add(Word(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        wordText: word
      ));
    });
    _wordController.clear();
  }
  // 사용자가 검색 상자에 입력한 키워드를 기반으로 단어를 필터링
  void _runFilter(String enteredKeyword) {
    List<Word> results = [];
    if (enteredKeyword.isEmpty) {
      results = wordsList;
    } else {
      results = wordsList.where((item) => item.wordText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    // 검색 결과를 _foundWord 에 업데이트
    setState(() {
      _foundWord = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 20,),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
