import 'dart:async';
import 'package:flutter/material.dart';

import 'category_practice.dart';

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
              builder: (context) => const CategoryScreenWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: const Color(0xFFACD2ED),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "HARU",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Megrim",
                    color: Colors.white,
                  ),
                ),
                Text(
                  "하루 한 번 지식",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "NanumSquare",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          //Container(
          //height : MediaQuery.of(context).size.height,
          //color: kPrimaryColor,
          //     Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     SizedBox(height: screenHeight * 0.384375),
          //     Container(
          //       child: SvgPicture.asset(
          //         imageLogoName,
          //         width: screenWidth * 0.616666,
          //         height: screenHeight * 0.0859375,
          //       ),
          //     ),
          //     const Expanded(child: SizedBox()),
          //     Align(
          //       child: Text("© Copyright 2020, 내방니방(MRYR)",
          //           style: TextStyle(
          //             fontSize: screenWidth * (14 / 360),
          //             color: const Color.fromRGBO(255, 255, 255, 0.6),
          //           )),
          //     ),
          //     SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.0625,
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
