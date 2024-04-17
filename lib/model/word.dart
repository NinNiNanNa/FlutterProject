class Word {
  String? id;
  String? wordText;
  bool isDone;

  Word({
    required this.id,
    required this.wordText,
    this.isDone = false,
  });

  static List<Word> wordList() {
    return [
      // Word(id: '01', wordText: '히히히히', isDone: true),
      // Word(id: '02', wordText: '쿄쿄쿄쿄쿄', isDone: true),
      // Word(id: '03', wordText: '우하하하하하',),
      // Word(id: '04', wordText: '이것은 단어장이라니껜ㅋㅋㅋㅋ',),
      // Word(id: '05', wordText: 'ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ',),
      // Word(id: '06', wordText: 'ㅎㅎㅎㅎㅎㅁㅁㅇㄴㄻㄴㅇㄹ',),
    ];
  }
}