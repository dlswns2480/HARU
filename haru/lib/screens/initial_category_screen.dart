import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
final List<IconData> iconList = <IconData>[
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
  'assets/images/mevius.jpg',
  'assets/images/atom.png',
];

class InitialCategorySelect extends StatefulWidget {
  const InitialCategorySelect({super.key});

  @override
  State<InitialCategorySelect> createState() => _InitialCategorySelectState();
}

class _InitialCategorySelectState extends State<InitialCategorySelect> {
  DateTime? currentBackPressTime;
  // Future<bool> onWillPop() async {
  // return await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.blue,
  //         title: const Text(
  //           "Do you want to exit?",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context, true);
  //               },
  //               child: const Text('끝내기')),
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context, false);
  //               },
  //               child: const Text('아니요')),
  //         ],
  //       );
  //     });
  //   DateTime now = DateTime.now();

  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     const msg = "'뒤로'버튼을 한 번 더 누르면 종료됩니다.";
  //     Fluttertoast.showToast(msg: "exit_warning");
  //     return Future.value(false);
  //   }
  //   return Future.value(true);
  // }
  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Do you want to exit the app?"),
        actions: <Widget>[
          TextButton(
            child: const Text("No"),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            //Navigator.pop(context, true),

            child: const Text("Yes"),
          )
        ],
      ),
    ).then((value) => value ?? false);
  }

  //bool check = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop, //() async => false,

      child: Scaffold(
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
          automaticallyImplyLeading: false,
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
      ),
    );
  }
}
