import 'package:flutter/material.dart';
import 'package:project_translator/model/word.dart';

class WordItem extends StatelessWidget {
  final Word word;
  final onWordChanged;
  final onDeleteItem;

  const WordItem({
    Key? key,
    required this.word,
    required this.onWordChanged,
    required this.onDeleteItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          // print('체크 버튼');
          onWordChanged(word);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: Colors.white,
        leading: Icon(word.isDone? Icons.check_box : Icons.check_box_outline_blank, color: Colors.indigo,),
        title: Text(
          word.wordText!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            decoration: word.isDone? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            icon: Icon(Icons.delete),
            iconSize: 18,
            color: Colors.white,
            onPressed: () {
              // print('삭제버튼');
              onDeleteItem(word.id);
            },
          ),
        ),
      ),
    );
  }
}