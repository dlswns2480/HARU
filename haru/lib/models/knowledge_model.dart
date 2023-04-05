class Knowledge {
  String title;
  String knowledge;

  Knowledge({
    required this.title,
    required this.knowledge,
  });

  factory Knowledge.fromJson(
      Map<String, dynamic> json, String category, int index) {
    return Knowledge(
      title: json[category][index]['title'], //["카테고리"][몇번 째 지식]['title']
      knowledge: json[category][index]
          ['knowledge'], //["카테고리"][몇번 째 지식]['knowledge']
    );
  }
}
