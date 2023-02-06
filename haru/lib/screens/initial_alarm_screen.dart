import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haru/screens/category_practice.dart';
import 'package:haru/screens/home_screen.dart';
import 'package:intl/intl.dart';

final List<String> data = <String>[];

class InitialAlarm extends StatefulWidget {
  const InitialAlarm({Key? key}) : super(key: key);

  @override
  _InitialAlarm createState() => _InitialAlarm();
}

class _InitialAlarm extends State<InitialAlarm> {
  // int counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();
  DateTime? tempPickedDate;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController alarmController =
      TextEditingController(text: '-');
  @override
  void initState() {
    // for (var i = 0; i < counter; i++) {
    //   data.add('${i + 1}');
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 3,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            "알림 설정",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "NanumSquare",
              // fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildAddBtn(),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: screenHeight * 0.4,
                      child: SingleChildScrollView(
                        child: ListView.separated(
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
                                onPressed: () => onDelete(context, index),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            height: 20,
                            thickness: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
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
                                  const CategoryScreenWidget()),
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
          ],
        ),
      ),
    );
  }

  Widget buildAddBtn() {
    return GestureDetector(
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          _selectDate();
          // data.add('${++counter}');
          // globalKey.currentState!.insertItem(data.length - 1);
        },
      ),
    );
  }

  void onDelete(context, index) {
    setState(() {
      data.removeAt(index);
    });
  }

  _selectDate() async {
    DateTime? pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: ThemeData.light().scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        // DateTime tempPickedDate;
        return SizedBox(
          height: 300,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: const Text('취소'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    CupertinoButton(
                      child: const Text('완료'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ],
                ),
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
      setState(() {
        _selectedDate = pickedDate;
        alarmController.text = pickedDate.toString();
        data.add(convertDateTimeDisplay(alarmController.text));
      });
    }
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('hh:mm  aaa');
    final DateTime displayDate = displayFormater.parse(date);
    return alarmController.text = serverFormater.format(displayDate);
  }
}
