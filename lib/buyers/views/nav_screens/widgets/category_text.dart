import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> _categoryLabel = ['foods', 'vegetables', 'eggs', 'teas'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(fontSize: 19),
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryLabel.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ActionChip(
                          backgroundColor: Colors.yellow.shade900,
                          onPressed: (){},
                          label: Center(
                            child: Text(
                              _categoryLabel[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.navigate_next,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
