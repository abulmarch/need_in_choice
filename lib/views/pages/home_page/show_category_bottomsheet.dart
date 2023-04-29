import 'package:flutter/material.dart';
import 'package:need_in_choice/views/pages/home_page/widgets.dart/scrolling_category.dart';

import '../../../config/routes/route_names.dart';
import '../../../utils/category_and_subcategory_info.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/rich_text_builder.dart';

class ShowCatogoryBottomSheet extends StatelessWidget {
  const ShowCatogoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController(initialPage: 0, keepPage: true,);
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(kpadding10))
        ),
        width: double.infinity,
        height: 275,
      child: LayoutBuilder(
        builder: (ctx, cons) => PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            //  firstpage:  Real estate category
            SizedBox(
              width: cons.maxWidth,
              height: cons.minHeight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // category scrolling
                  const SizedBox(
                    height: 90,
                    child: ScrollingCategory(selectedCategory: 0, size: 90),
                  ),
                  DashedLineGenerator(width: cons.maxWidth),
                  //  Sub category under real-estate category
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(top: kpadding10),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5
                      ),
                      itemCount: realEstateSubCategory.length,
                      itemBuilder: (context, index) => InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index==0 ? kEnabledBackground : kDisabledBackground,
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            border: index==0 ? Border.all(color: kPrimaryColor,) : null,
                          ),
                          child: Text(
                            realEstateSubCategory[index].toUpperCase(),
                            style: TextStyle(
                              color: index==0 ? kPrimaryColor : kDisabledText,
                              fontWeight: FontWeight.w600,
                            ),//------------------------------
                          )
                        ),
                        onTap: () {
                          switchPage(1, pageController);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            //  secondpage: subcategory under Building for sale  sub_category
            Stack(
              children: [
                // category image and category name list
                Container(
                  width: cons.maxWidth,
                  height: cons.minHeight,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: kpadding20),
                    child: SingleChildScrollView(
                      child: Wrap(                  
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        children: List.from(realEstateBuildingForSale.map((subCat) => InkWell(
                          child: Container(
                            width: cons.maxWidth/3,
                            height: cons.maxHeight/3+25,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            foregroundDecoration: subCat['cat_name']! != 'COMMERCIAL BUILDING' ? const BoxDecoration(
                              color: Colors.grey,
                              backgroundBlendMode: BlendMode.saturation,
                            ) : null,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Image.asset('assets/images/ellipse.png'),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Image.asset(subCat['cat_img']!,),//assets/images/category/realestate.png
                                    ),
                                  ],
                                ),
                                RichTextBuilder.lastWord(text: subCat['cat_name']!.toUpperCase(),),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(collectAdDetails);
                          },
                        ))),
                      ),
                    ),
                  ),
                ),
                // top left back arrow
                Positioned(
                  top: -9,
                  left: -9,
                  child: CircularBackButton(
                    onPressed: () {
                      switchPage(0, pageController);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void switchPage(int index, PageController pageController) {

  // use this to animate to the page
  pageController.animateToPage(index,duration: const Duration(milliseconds: 300,),curve: Curves.easeInOut);

    // or this to jump to it without animating
    // pageController.jumpToPage(index);
  }
}