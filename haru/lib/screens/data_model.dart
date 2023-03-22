class Person {
  String name;
  String email;
  int age;

  Person({required this.name, required this.email, required this.age});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      email: json['email'],
      age: json['age'],
    );
  }
}
