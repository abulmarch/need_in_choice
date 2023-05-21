import 'package:flutter/material.dart';
import '../../../utils/category_data.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/rich_text_builder.dart';
import 'widgets.dart/scrolling_category.dart';

class ShowCatogoryBottomSheet extends StatelessWidget {
  const ShowCatogoryBottomSheet({
    super.key, 
    this.level2SubCat = realEstateSubCategory,
    this.selectedMainCatIndex = 0,
  });
  final List<Map<String, dynamic>> level2SubCat;
  final int selectedMainCatIndex;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    ValueNotifier<List<Map<String, dynamic>>> categoryNotifier = ValueNotifier(level2SubCat);
    ValueNotifier<List<Map<String, dynamic>>> subCategoryNotifier = ValueNotifier([]);
    ValueNotifier<int> selectedMainCategory = ValueNotifier(selectedMainCatIndex);
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.all(Radius.circular(kpadding10))
      ),
      width: double.infinity,
      height: 300,
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
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: mainCategories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                          valueListenable: selectedMainCategory,
                          builder: (context, selectedIndex, _) {
                            return MainCategoryIconWithName(
                              onTap: () {
                                if(mainCategories[index]['is_comming_soon']!=null){
                                  categoryNotifier.value = mainCategories[index]['next_cat_list'];
                                }else if(mainCategories[index]['end_of_cat'] == true){
                                  Navigator.of(context).pushNamed(mainCategories[index]['root_name']);
                                }else{
                                  categoryNotifier.value = mainCategories[index]['next_cat_list'];
                                }
                                selectedMainCategory.value = index;
                              },
                              selectedCategory: selectedIndex, 
                              size: 90,
                              index: index,
                            );
                          }
                        );
                      }
                    ),
                  ),
                  DashedLineGenerator(width: cons.maxWidth),
                  //  Sub category under real-estate category
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: kpadding10),
                        physics: const BouncingScrollPhysics(),
                        child: ValueListenableBuilder(
                          valueListenable: categoryNotifier,
                          builder: (context, level2SubCatList, _) {
                            return Wrap(
                              runSpacing: kpadding10,spacing: 5,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.spaceAround,
                              runAlignment: WrapAlignment.center,
                              children: List.from(level2SubCatList.map((subCate) => InkWell(
                                onTap: () {
                                  if(subCate['cat_name'] != 'COMMING SOON'){
                                    if(subCate['end_of_cat'] == true){
                                      Navigator.of(context).pushNamed(subCate['root_name']);
                                    }else{
                                      subCategoryNotifier.value = subCate['next_cat_list'];
                                      switchPage(1, pageController);
                                    }
                                  }
                                },
                                child: subCategoryGreyContainer(cons, subCate['cat_name']),
                              ))),
                            );
                          }
                        ),
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
                      child: ValueListenableBuilder(
                        valueListenable: subCategoryNotifier,
                        builder: (context, level3SubCatList, _) {
                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: List.from(level3SubCatList.map((subCat) => InkWell(
                              child: Container(
                                width: cons.maxWidth / 3,
                                height: cons.maxHeight / 3 + 25,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                foregroundDecoration: subCat['cat_name']! != 'COMMERCIAL BUILDING'
                                  ? const BoxDecoration(
                                    color: Colors.grey,
                                    backgroundBlendMode: BlendMode.saturation,
                                  )
                                  : null,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Image.asset('assets/images/ellipse.png'),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Image.asset(subCat['cat_img']!,
                                          ), //assets/images/category/realestate.png
                                        ),
                                      ],
                                    ),
                                    RichTextBuilder.firstWord(
                                      text:subCat['cat_name']!.toUpperCase(),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(subCat['root_name']);
                              },
                            ))),
                          );
                        }
                      ),
                    ),
                  ),
                ),
                // top left back arrow
                Positioned(
                  top: -4,
                  left: -4,
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

  Container subCategoryGreyContainer(BoxConstraints cons, String subCate) {
    return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                // width: cons.maxWidth*0.45,
                                constraints: BoxConstraints(
                                  minWidth: cons.maxWidth*0.3,
                                  maxWidth: cons.maxWidth,
                                  minHeight: 35,
                                ),
                                decoration: const BoxDecoration(
                                  color: kDisabledBackground,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Text(
                                  subCate,
                                  style: const TextStyle(
                                    color: kDisabledText,
                                    fontWeight: FontWeight.w600,
                                  ), //------------------------------
                                ),
                              );
  }

  void switchPage(int index, PageController pageController) {
    // use this to animate to the page
    pageController.animateToPage(index,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeInOut);

    // or this to jump to it without animating
    // pageController.jumpToPage(index);
  }
}
