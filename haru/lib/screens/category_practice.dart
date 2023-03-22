// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haru/screens/initial_alarm_screen.dart';
// import 'package:google_fonts/google_fonts.dart';

class CategoryScreenWidget extends StatefulWidget {
  const CategoryScreenWidget({Key? key}) : super(key: key);

  @override
  _CategoryScreenWidgetState createState() => _CategoryScreenWidgetState();
}

class _CategoryScreenWidgetState extends State<CategoryScreenWidget> {
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

  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _appBar = AppBar(
    // backgroundColor: const Color(0xFFACD2ED),
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
  );
  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // backgroundColor: const Color(0xFFACD2ED),
        backgroundColor: Colors.white,
        key: scaffoldKey,
        // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            Container(
              height: 1.0,
              width: 400.0,
              color: Colors.black12,
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            SizedBox(
              height: screenHeight * 0.65,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CategoryCard(
                          title: "명언",
                          imagePath: "assets/images/category_images/saying.jpg",
                        ),
                        CategoryCard(
                          title: "과학",
                          imagePath:
                              "assets/images/category_images/science.jpg",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CategoryCard(
                          title: "천체",
                          imagePath: "assets/images/category_images/saying.jpg",
                        ),
                        CategoryCard(
                          title: "IT",
                          imagePath: "assets/images/category_images/IT.jpg",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CategoryCard(
                          title: "경제",
                          imagePath:
                              "assets/images/category_images/economy.jpg",
                        ),
                        CategoryCard(
                          title: "영어",
                          imagePath:
                              "assets/images/category_images/english.jpg",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CategoryCard(
                          title: "의료",
                          imagePath:
                              "assets/images/category_images/medical.jpg",
                        ),
                        CategoryCard(
                          title: "생활지식",
                          imagePath: "assets/images/category_images/saying.jpg",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
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
        // SizedBox(
        //   width: 100,
        //   height: 50,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const InitialAlarm()),
        //       );
        //     },
        //     style: ButtonStyle(
        //       alignment: Alignment.bottomRight,
        //       backgroundColor: MaterialStateProperty.all(Colors.black),
        //     ),
        //     child: const Text('다음'),
        //   ),
        // ),
        // ],
      ),
    );
    // ),
    // )
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 170,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
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
          padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 115,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 0, 0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "NanumSquareRound",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
