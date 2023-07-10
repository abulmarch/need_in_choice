import 'package:flutter/material.dart';

import '../../../../utils/category_data.dart';
import '../../../widgets_refactored/rich_text_builder.dart';

class MainCategoryIconWithName extends StatelessWidget {
  const MainCategoryIconWithName({
    super.key,
    required this.size,
    required this.selectedCategory,
    required this.index,
    this.onTap,
  });

  final int selectedCategory;
  final int index;
  final double size;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        foregroundDecoration: selectedCategory != index
            ? const BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
              )
            : null,
        width: size,
        height: size,
        // margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.asset('assets/images/ellipse.png'),
                ),
                Image.asset(mainCategories[index]['cat_img']!,
                    width: size * 0.5), //assets/images/category/realestate.png
              ],
            ),
            RichTextBuilder(
              overflow: TextOverflow.ellipsis,
              text: mainCategories[index]['cat_name']!
                  .toUpperCase(), //'REAL ESTATE'
            ),
          ],
        ),
      ),
    );
  }
}
