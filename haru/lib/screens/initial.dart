import 'package:flutter/material.dart';

var categoryItem = ['운동', '의료', '건강', '명언', '과학', 'IT', '경제', '영어', 'etc'];
var categoryimage = [
  'images/atom.png',
];

class CategorySelect extends StatelessWidget {
  const CategorySelect({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
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
                        Container(
                          width: 115,
                          height: 115,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                'images/atom.png',
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 2.0),
                          ),
                        ),
                        Text(
                          categoryItem[index],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text('다음'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
