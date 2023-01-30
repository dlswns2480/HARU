import 'package:flutter/material.dart';
import 'package:haru/screens/home_screen.dart';

class InitialAlarm extends StatefulWidget {
  const InitialAlarm({super.key});

  @override
  State<InitialAlarm> createState() => InitialAlarmtState();
}

class InitialAlarmtState extends State<InitialAlarm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "알림 시간",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 100,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 550,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text('다음'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
