class Person {
  String title;
  String knowledge;
  String imagePath;
  String author;

  Person({
    required this.title,
    required this.knowledge,
    required this.imagePath,
    required this.author,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      title: json['title'],
      knowledge: json['knowledge'],
      imagePath: json['imagePath'],
      author: json['author'],
    );
  }
}
