import 'package:flutter/material.dart';
import 'package:haru/screens/initial_category_screen.dart';

class Webtoon extends StatelessWidget {
  final String name;

  const Webtoon({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InitialCategorySelect(),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: name,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
