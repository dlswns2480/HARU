class Knowledge {
  String title;
  String knowledge;

  Knowledge({
    required this.title,
    required this.knowledge,
  });

  factory Knowledge.fromJson(Map<String, dynamic> json) {
    return Knowledge(
      title: json['title'],
      knowledge: json['knowledge'],
    );
  }
}
