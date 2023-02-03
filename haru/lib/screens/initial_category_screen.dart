import 'package:flutter/material.dart';
import 'package:haru/screens/initial_alarm_screen.dart';

var categoryItem = [
  '운동',
  '의료',
  '건강rkdrkd',
  '명언',
  '과학',
  'IT',
  '경제',
  '영어',
  'etc',
];
final List<IconData> icon_list = <IconData>[
  Icons.health_and_safety_outlined,
  Icons.medical_information,
  Icons.health_and_safety_outlined,
  Icons.health_and_safety_outlined,
  Icons.health_and_safety_outlined,
  Icons.health_and_safety_outlined,
  Icons.health_and_safety_outlined,
  Icons.health_and_safety_outlined,
  Icons.ac_unit_rounded
];

final List<bool> _selectedCategorys = <bool>[
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

var categoryimage = [
  'assets/images/mevius.jpg',
  'assets/images/mevius.jpg',
  'assets/images/atom.png',
  'assets/images/mevius.jpg',
  'assets/images/atom.png',
  'assets/images/mevius.jpg',
  'assets/images/atom.png',
  'assets/images/workout.jpg',
  'assets/images/atom.png',
];

class InitialCategorySelect extends StatefulWidget {
  const InitialCategorySelect({super.key});

  @override
  State<InitialCategorySelect> createState() => _InitialCategorySelectState();
}

class _InitialCategorySelectState extends State<InitialCategorySelect> {
  //bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "카테고리 선택",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 80,
          ),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(9, (index) {
                  return Center(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategorys[index] =
                                  !_selectedCategorys[index];
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  categoryimage[index],
                                ),
                              ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: _selectedCategorys[index]
                                      ? Colors.blue
                                      : Colors.black,
                                  width: 3.5),
                            ),
                            // child: Icon(
                            //   size: 50,
                            //   icon_list[index],
                            //   color: _selectedCategorys[index]
                            //       ? Colors.blue
                            //       : Colors.black,
                            // ),
                          ),
                        ),
                        Text(
                          categoryItem[index],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InitialAlarm()),
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
