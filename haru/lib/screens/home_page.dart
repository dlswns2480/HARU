import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haru/models/knowledge_model.dart';

import 'dart:async';

final nowTime = DateTime.now();
final fiftyDaysFromNow = nowTime.add(const Duration(minutes: 1));
int lastIndex = 0;

var category = ['운동', '의료', '건강', '명언', '과학', 'IT', '경제', '영어'];

int categoryIndex = 0;
Future<String> _loadKnowledgeAsset() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<Knowledge> _getKnowledgeData() async {
  String jsonString = await _loadKnowledgeAsset();
  final jsonResponse = json.decode(jsonString);

  Timer.periodic(const Duration(seconds: 3), (Timer t) {
    lastIndex++; //매 주기마다 index를 증가시켜 data를 주기마다 다른 것을 가져옴
    if (lastIndex > 2) {
      // 3초마다 Timer.periodic안에 있는 구문을 실행
      lastIndex = 0;
    }
  });
  return Knowledge.fromJson(
      jsonResponse, category[lastIndex], lastIndex); // 현재 운동 카테고리의 2번째 지식입니다.
}

DateTime dt = DateTime.now();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Knowledge>(
      future: _getKnowledgeData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeKnowledgeWidget(
            title: snapshot.data!.title,
            knowledge: snapshot.data!.knowledge,
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
class HomeKnowledgeWidget extends StatefulWidget {
  final String title;
  final String knowledge;

  const HomeKnowledgeWidget({
    super.key,
    required this.title,
    required this.knowledge,
  });

  @override
  State<HomeKnowledgeWidget> createState() => _HomeKnowledgeWidgetState();
}

class _HomeKnowledgeWidgetState extends State<HomeKnowledgeWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFACD2ED),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle_outlined,
            ),
          ),
        ],
        title: const Text(
          "하루지식",
          style: TextStyle(
            fontFamily: "NanumGothic",
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_circle_down_rounded),
                    SizedBox(width: 10),
                    Text("당겨서 새로고침"),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_circle_down_rounded),
                  ],
                ),
              ),
              Container(
                width: screenWidth * 0.95,
                height: screenHeight * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/category_images/IT.jpeg",
                    ),
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: const Color(0x59000000),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24, 70, 24, 44),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 0, 0),
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
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.4,
                        decoration: const BoxDecoration(
                          color: Color(0x87000000),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24, 24, 24, 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontFamily: "NanumSquare",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: screenWidth * 0.9,
                                  height: 2,
                                  decoration: const BoxDecoration(
                                    color: Color(0x34FFFFFF),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.9,
                                  height: screenHeight * 0.2,
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
                                              text: widget.knowledge,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
