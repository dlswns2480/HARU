import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haru/screens/initial_category_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const InitialCategorySelect()));
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imageLogoName = 'images/atom.png';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: const Scaffold(
            backgroundColor: Colors.white, body: Text("aasdasd")
            //Container(
            //   //height : MediaQuery.of(context).size.height,
            //   //color: kPrimaryColor,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            //       SizedBox(height: screenHeight * 0.384375),
            //       Container(
            //         child: SvgPicture.asset(
            //           imageLogoName,
            //           width: screenWidth * 0.616666,
            //           height: screenHeight * 0.0859375,
            //         ),
            //       ),
            //       const Expanded(child: SizedBox()),
            //       Align(
            //         child: Text("© Copyright 2020, 내방니방(MRYR)",
            //             style: TextStyle(
            //               fontSize: screenWidth * (14 / 360),
            //               color: const Color.fromRGBO(255, 255, 255, 0.6),
            //             )),
            //       ),
            //       SizedBox(
            //         height: MediaQuery.of(context).size.height * 0.0625,
            //       ),
            //     ],
            //   ),
            // ),
            ),
      ),
    );
  }
}
