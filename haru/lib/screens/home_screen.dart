import 'package:flutter/material.dart';

int screenIndex = 0;
List<Widget> screenList = [
  const Text('카테고리'),
  const Text('홈'),
  const Text('알람')
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Haru Knowledge'),
        ),
        body: screenList[screenIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded), label: 'category'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.alarm_rounded), label: 'alarm')
          ],
          onTap: (value) {
            setState(() {
              //상태 갱신이 되지 않으면 동작을 하지 않음
              screenIndex = value;
            });
          },
        ));
  }
}
