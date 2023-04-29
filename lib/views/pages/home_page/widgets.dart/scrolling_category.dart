import 'package:flutter/material.dart';

import '../../../../utils/category_and_subcategory_info.dart';
import '../../../widgets_refactored/rich_text_builder.dart';

class ScrollingCategory extends StatelessWidget {
  const ScrollingCategory({
    super.key,
    required int selectedCategory, required this.size,
  }) : _selectedCategory = selectedCategory;

  final int _selectedCategory;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: mainCategories.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          foregroundDecoration: _selectedCategory != index ? const BoxDecoration(
            color: Colors.grey,
            backgroundBlendMode: BlendMode.saturation,
          ) : null,
          width: size,
          height: size,
          // margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image.asset('assets/images/ellipse.png'),
                  ),
                  Image.asset(mainCategories[index]['cat_img']!,width: size*0.65),//assets/images/category/realestate.png
                ],
              ),

              RichTextBuilder(
                overflow: TextOverflow.ellipsis,
                text: mainCategories[index]['cat_name']!.toUpperCase(),//'REAL ESTATE'
              ),
            ],
          ),
        );
      },
    );
  }
}