import 'package:flutter/material.dart';
import 'package:haru/screens/home_test.dart';
import 'package:haru/screens/initial_alarm_screen.dart';
import 'package:haru/screens/initial_category_screen.dart';
// int screenIndex = 0;
// List<Widget> _children = [
//   const Text('카테고리'),
//   const Text('홈'),
//   const Text('알람')
// ];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // final List<Widget> _children = [
  //   const HomeScreen(),
  //   const InitialAlarm(),
  //   const CategorySelect()
  // ];
  final List _children = [
    // const Text("1번입니다"),
    // const Text("1번입니다"),
    // const Text("1번입니다"),
    const HomeTest(),
    const InitialAlarm(),
    const InitialCategorySelect(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Haru home"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home22",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: "alarm",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "category",
          )
        ],
      ),
      body: _children[_selectedIndex],
    );
  }
}
