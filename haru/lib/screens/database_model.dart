class DatabaseModel {
  final String id; //해당 도큐먼트의 ID를 담기위함.
  final String content;

  DatabaseModel({this.id = '', this.content = ''});

  //서버로부터 map형태의 자료를 DatabaseModel형태의 자료로 변환해주는 역할을 수행함.
  factory DatabaseModel.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    return DatabaseModel(
      id: id,
      content: map['content'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['content'] = content;
    return data;
  }
}
