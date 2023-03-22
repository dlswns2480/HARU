import 'package:flutter/material.dart';
import 'package:haru/screens/initial_category_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class CategorySelect extends InitialCategorySelect_02 {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
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
    return Scaffold(
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
            height: MediaQuery.of(context).size.height * 0.05,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(8, (index) {
                        return Center(
                          child: SingleChildScrollView(
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              15, 10, 15, 10),
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8, 12, 0, 0),
                                            child: Text(
                                              categoryItem[index],
                                              style: TextStyle(
                                                fontFamily: "NanumSquareRound",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                color: _selectedCategorys[index]
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
                          ),
                        );
                      }),
                    ),
                  ],
                ),
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
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
