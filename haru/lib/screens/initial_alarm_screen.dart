import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haru/screens/home_screen.dart';
import 'package:haru/screens/initial_category_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haru/widgets/daily_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final List<String> data = <String>[];

final List<bool> setTime = <bool>[
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

final _appBar = AppBar(
  // backgroundColor: const Color(0xFFACD2ED),
  backgroundColor: Colors.white,
  automaticallyImplyLeading: false,
  title: const Text(
    'Setting Alarm!',
    style: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontFamily: "Megrim",
      fontWeight: FontWeight.w900,
    ),
  ),
  actions: const [],
  centerTitle: true,
  elevation: 0,
);

class InitialAlarm extends StatefulWidget {
  const InitialAlarm({super.key});

  @override
  State<InitialAlarm> createState() => _InitialAlarm();
}

class _InitialAlarm extends State<InitialAlarm> {
  // int counter = 5;

  late SharedPreferences prefs;

  // final settingTimes = prefs.getStringList('settingTimes') ?? [];

  final globalKey = GlobalKey<AnimatedListState>();
  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController alarmController =
      TextEditingController(text: '-');

  Future initprefs() async {
    prefs = await SharedPreferences.getInstance();
    final settingTimes = prefs.getStringList('settingTimes') ?? [];
    // print(settingTimes);
    if (settingTimes.isNotEmpty) {
      data.clear();
      for (int i = 0; i < settingTimes.length; i++) {
        setState(() {
          data.add(settingTimes[i]);
        });
      }
      await prefs.setStringList('settingTimes', settingTimes);
    } else {
      await prefs.setStringList('settingTimes', []);
    }
  }

  @override
  void initState() {
    // for (var i = 0; i < counter; i++) {
    //   data.add('${i + 1}');
    // }
    super.initState();
    initprefs();
  }

  // addSettingTime(int index) async {
  //   final settingTime = prefs.getStringList('settingTime') ?? [];
  //   if (setTime[index]) {
  //     settingTime.remove(data[index]);
  //   } else {
  //     settingTime.add(data[index]);
  //   }
  //   await prefs.setStringList('settingTime', settingTime);
  //   setState(() {
  //     final settingTime = prefs.getStringList('settingTimes') ?? [];
  //     setTime[index] = !setTime[index];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                      child: Text(
                        'Alarm',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Megrim",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1.0,
              width: 400.0,
              color: Colors.black12,
            ),
            SizedBox(
              height: screenHeight * 0.65,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          key: ValueKey(data[index]),
                          title: Text(
                            data[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 40,
                              fontFamily: "NanumSquareRound",
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.close,
                              // Icons.remove_circle_outline_rounded,
                              color: Colors.red,
                              size: 30,
                            ),
                            onPressed: () => {
                              onDelete(context, index),
                              dailyAtTimeNotification(data),
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 20,
                        thickness: 2,
                      ),
                    ),
                    // const Divider(
                    //   height: 20,
                    //   thickness: 2,
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildAddBtn(),
                  ],
                ),
              ),
            ),
            Container(
              height: 1.0,
              width: 400.0,
              color: Colors.black12,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: screenHeight * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const SizedBox(
                    //   width: 20,
                    // ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const InitialCategorySelect_02()),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text(
                          '이전',
                          style: TextStyle(
                            fontFamily: "Megrim",
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 100,
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
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            fontFamily: "Megrim",
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 0,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddBtn() {
    if (data.length >= 5) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        //Dialog Main Title
        title: Column(
          children: const <Widget>[
            Text("알림은 최대 5개까지 생성 가능합니다."),
          ],
        ),
      );
    } else {
      return Container(
        height: 70,
        width: 350,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: GestureDetector(
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              // addSettingTime(index);
              _selectDate();
              // data.add('${++counter}');
              // globalKey.currentState!.insertItem(data.length - 1);
            },
          ),
        ),
      );
    }
  }

  Future<void> onDelete(context, index) async {
    final settingTimes = prefs.getStringList('settingTimes') ?? [];

    setState(() {
      data.removeAt(index);
    });
    settingTimes.removeAt(index);
    await prefs.setStringList('settingTimes', settingTimes);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();
    dailyAtTimeNotification(data);
  }

  _selectDate() async {
    final settingTimes = prefs.getStringList('settingTimes') ?? [];

    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      context: context,
      // index : index,
      builder: (context) {
        // DateTime tempPickedDate;
        return SizedBox(
          height: 300,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: const Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                      // settingTimes.()remove()
                    },
                  ),
                  CupertinoButton(
                    child: const Text('완료'),
                    onPressed: () async {
                      Navigator.of(context).pop(tempPickedDate);
                      FocusScope.of(context).unfocus();
                      dailyAtTimeNotification(data);
                      // settingTimes.add(tempPickedDate.toString());
                      // await prefs.setStringList('settingTimes', settingTimes);
                      // setState(() => setTime[0] = !setTime[0]);
                    },
                  ),
                ],
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (pickedDate != null) {
      final settingTimes = prefs.getStringList('settingTimes') ?? [];

      setState(() {
        _selectedDate = pickedDate;
        alarmController.text = pickedDate.toString();
        data.add(convertDateTimeDisplay(alarmController.text));
        // settingTimes.add(data[0]);
      });
      settingTimes.add(data[data.length - 1]);
      await prefs.setStringList('settingTimes', settingTimes);
    }
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('hh:mm  aaa');
    final DateTime displayDate = displayFormater.parse(date);
    return alarmController.text = serverFormater.format(displayDate);
  }
}
