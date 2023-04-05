import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haru/widgets/daily_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  int _lastDisplayedIndex = 0;
  late List<Person> _dataList;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastDisplayedIndex = prefs.getInt('lastDisplayedIndex') ?? 0;
    await loadData();
  }

  Future<void> loadData() async {
    final String jsonString = await rootBundle.loadString('assets/data.json');
    final List<dynamic> data = jsonDecode(jsonString);
    _dataList = data.map((e) => Person.fromJson(e)).toList();
  }

  Person getNextData() {
    if (_lastDisplayedIndex >= _dataList.length) {
      _lastDisplayedIndex = 0;
    }
    final Person nextData = _dataList[_lastDisplayedIndex];
    _lastDisplayedIndex++;
    return nextData;
  }

  Future<void> updateLastDisplayedIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastDisplayedIndex', _lastDisplayedIndex);
  }
}

Future<String> _loadPersonAsset() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<Person> _getPersonData() async {
  String jsonString = await _loadPersonAsset();
  final jsonResponse = json.decode(jsonString);
  return Person.fromJson(jsonResponse);
}

DateTime dt = DateTime.now();

DateTime calculateNotificationTime() {
  // Calculate the notification time based on the user's settings
  return DateTime.now().add(const Duration(minutes: 1));
}

class HomeTest extends StatefulWidget {
  const HomeTest({super.key});

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  final DataManager _dataManager = DataManager();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person>(
      future: _getPersonData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeKnowledgeWidget(
            title: _dataManager.getNextData().title, //snapshot.data!.title,
            titleLarge: _dataManager.getNextData().title,
            knowledge: _dataManager.getNextData().knowledge,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );

    // const Scaffold(
    //   body: HomeKnowledgeWidget(
    //     title: "경제",
    //     imagePath:
    //         "https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80",
    //     knowledge:
    //         " 그레이 캐피털리즘(Gray Capitalism)이란 정부 통제력이 강한 기존 중국식 자본주의에서 통제를 풀고 시장을 확대하는 과정에 있는 중간적 형태의 자본주 의를 뜻한다.",
    //     author: "null",
    //   ),
    // );
  }
}

@immutable
class HomeKnowledgeWidget extends StatelessWidget {
  final String title;

  final String knowledge;
  final String titleLarge;
  const HomeKnowledgeWidget({
    super.key,
    required this.title,
    required this.knowledge,
    required this.titleLarge,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/category_images/IT.jpeg",
                ),
              ),
            ),
            child: Container(
              width: 100,
              height: 10,
              decoration: const BoxDecoration(
                color: Color(0x59000000),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24, 70, 24, 44),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '오늘의 지식',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "NanumSquareRound",
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            '${dt.year}.${dt.month}.${dt.day}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 6,
                          sigmaY: 7,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: const BoxDecoration(
                            color: Color(0x87000000),
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  24, 24, 24, 24),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontFamily: "NanumSquare",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 80,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 2,
                                      decoration: const BoxDecoration(
                                        color: Color(0x34FFFFFF),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 100,
                                                strutStyle: const StrutStyle(
                                                    fontSize: 16.0),
                                                text: TextSpan(
                                                  text: knowledge,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontFamily: 'NanumSquare',
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 2,
                                      decoration: const BoxDecoration(
                                        color: Color(0x34FFFFFF),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        // (author != "null")
                                        //     ? Text(
                                        //         author,
                                        //         style: const TextStyle(
                                        //             color: Colors.white54,
                                        //             fontFamily:
                                        //                 'NanumGothicEco',
                                        //             fontWeight: FontWeight.w300,
                                        //             fontSize: 20),
                                        //       )
                                        // : const Text(""),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
