import 'dart:ui';

import 'package:flutter/material.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({super.key});

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1569769107543-e0f61bab8e02?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80',
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
                        children: const [
                          Text(
                            '오늘의 지식',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                            // style: FlutterFlowTheme.of(context).title1.override(
                            //       fontFamily: 'Poppins',
                            //       color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text(
                              '2023-02-01',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 15,
                              ),

                              // style: FlutterFlowTheme.of(context)
                              //     .bodyText2
                              //     .override(
                              //       fontFamily: 'Poppins',
                              //       color: const Color(0xFFD5DBDF),
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
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            '"Think Different"',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                            // style: FlutterFlowTheme.of(context).bodyText1.override(
                                            //       fontFamily: 'Poppins',
                                            //       color: Colors.white,
                                            //       fontSize: 25,
                                            //     ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 2,
                                        decoration: const BoxDecoration(
                                          color: Color(0x34FFFFFF),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                          Text(
                                            'Steve Jobs',
                                            style: TextStyle(
                                              color: Colors.white54,
                                            ),
                                            // style: FlutterFlowTheme.of(context).bodyText1.override(
                                            //       fontFamily: 'Poppins',
                                            //       color: Colors.white,
                                            //       fontSize: 20,
                                            //     ),
                                          ),
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
      ),
    );
  }
}
