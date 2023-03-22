import 'package:flutter/material.dart';
import 'package:haru/screens/initial_alarm_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

var categoryItem = [
  '운동',
  '의료',
  '건강',
  '명언',
  '과학',
  'IT',
  '경제',
  '영어',
];

final List<String> categoryImageList = <String>[
  "assets/images/category_images/muscle.jpg",
  "assets/images/category_images/medical.jpg",
  "assets/images/category_images/health.jpg",
  "assets/images/category_images/saying.jpg",
  "assets/images/category_images/science.jpg",
  "assets/images/category_images/IT.jpg",
  "assets/images/category_images/economy.jpg",
  "assets/images/category_images/english.jpg",
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
];

var categoryimage = [
  'assets/images/atom.png',
];

class InitialCategorySelect_02 extends StatefulWidget {
  const InitialCategorySelect_02({super.key});

  @override
  State<InitialCategorySelect_02> createState() =>
      _InitialCategorySelect_02State();
}

class _InitialCategorySelect_02State extends State<InitialCategorySelect_02> {
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

  late SharedPreferences prefs;

  Future initprefs() async {
    prefs = await SharedPreferences.getInstance();
    final selectedCategory = prefs.getStringList('selectedCategory') ?? [];
    if (selectedCategory.isNotEmpty) {
      for (int i = 0; i < categoryItem.length; i++) {
        if (selectedCategory.contains(categoryItem[i])) {
          setState(() {
            _selectedCategorys[i] = true;
          });
        }
      }
    } else {
      await prefs.setStringList('selectedCategory', []);
    }
  }

  @override
  void initState() {
    super.initState();
    initprefs();
  }

  onCategoryTap(int index) async {
    final selectedCategory = prefs.getStringList('selectedCategory') ?? [];
    if (_selectedCategorys[index]) {
      selectedCategory.remove(categoryItem[index]);
    } else {
      selectedCategory.add(categoryItem[index]);
    }
    await prefs.setStringList('selectedCategory', selectedCategory);
    setState(() {
      _selectedCategorys[index] = !_selectedCategorys[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text(
            'Choose your interests!',
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
        ),
        body: Column(
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
                        'Categories',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Megrim",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Text(
                    //   'See All',
                    //   style: TextStyle(
                    //     fontFamily: "NanumSquare",
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const Line(),
            SizedBox(
              height: screenHeight * 0.7,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.0001,
                    ),
                    SizedBox(
                      height: screenHeight * 0.68,
                      child: SingleChildScrollView(
                        child: GridView.count(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: List.generate(8, (index) {
                            return Center(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        onCategoryTap(index);
                                        // _selectedCategorys[index] =
                                        //     !_selectedCategorys[index];
                                      });
                                    },
                                    child: Container(
                                      width: screenWidth * 0.4,
                                      height: 170,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _selectedCategorys[index]
                                              ? Colors.blue
                                              : Colors.black,
                                        ),
                                        // color: FlutterFlowTheme.of(context).secondaryBackground,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Colors.white,
                                            blurStyle: BlurStyle.solid,
                                            offset: Offset(0, 0),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15, 10, 15, 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.asset(
                                                categoryImageList[index],
                                                width: double.infinity,
                                                height: 115,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(8, 4, 0, 0),
                                              child: Text(
                                                categoryItem[index],
                                                style: TextStyle(
                                                  fontFamily:
                                                      "NanumSquareRound",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                  color:
                                                      _selectedCategorys[index]
                                                          ? Colors.blue
                                                          : Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Line(),
            SizedBox(
              height: screenHeight * 0.1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      height: screenHeight * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InitialAlarm()),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.0005,
      width: screenWidth * 0.9,
      color: Colors.black12,
    );
  }
}
