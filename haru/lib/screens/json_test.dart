// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;
// import 'data_model.dart';

// Future<String> _loadPersonAsset() async {
//   return await rootBundle.loadString('assets/data.json');
// }

// Future<Person> _getPersonData() async {
//   String jsonString = await _loadPersonAsset();
//   final jsonResponse = json.decode(jsonString);
//   return Person.fromJson(jsonResponse);
// }

// class JsonTest extends StatelessWidget {
//   const JsonTest({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Person>(
//       future: _getPersonData(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text('Name: ${snapshot.data!.name}\n'
//               'Age: ${snapshot.data!.age}\n'
//               'Email: ${snapshot.data!.email}');
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
