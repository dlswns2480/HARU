import 'package:flutter/material.dart';
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
  'etc',
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
  false,
];

var categoryimage = [
  'assets/images/atom.png',
];

class CategorySelect extends StatefulWidget {
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
        elevation: 3,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "카테고리 선택",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 80,
          ),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(9, (index) {
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
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              // image: const DecorationImage(
                              //   image: AssetImage(
                              //     'images/atom.png',
                              //   ),
                              // ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: _selectedCategorys[index]
                                      ? Colors.blue
                                      : Colors.black,
                                  width: 3.5),
                            ),
                            child: Icon(
                              size: 50,
                              iconList[index],
                              color: _selectedCategorys[index]
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          categoryItem[index],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                width: 350,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
