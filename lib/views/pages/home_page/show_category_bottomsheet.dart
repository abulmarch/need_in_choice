import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/main_category_bloc/main_category_bloc.dart';
import '../../../utils/category_data.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/circular_back_button.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/lottie_widget.dart' show LottieWidget;
import '../../widgets_refactored/rich_text_builder.dart';
import 'home_screen.dart';
import 'widgets.dart/scrolling_category.dart';

class ShowCatogoryBottomSheet extends StatefulWidget {
  const ShowCatogoryBottomSheet({
    super.key,
    this.selectedCategory = 0,
    required this.purpose,
  });
  final int selectedCategory;
  final CategoryBottomSheetPurpose purpose;

  @override
  State<ShowCatogoryBottomSheet> createState() => _ShowCatogoryBottomSheetState();
}

class _ShowCatogoryBottomSheetState extends State<ShowCatogoryBottomSheet> {
  late final PageController _pageController;// for switching  level 2 and level 3 category
  List<Map<String, dynamic>> _levelTwoSubCatList = [];
  List<Map<String, dynamic>> _levelThreeSubCatList = [];

  // late final CategoryBottomSheetPurpose purpose;

  String? _selectedL2SubCatName;// for highlighting selected level 2 category
  String? _selectedL3SubCatName;// for highlighting selected level 3 category

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
    // purpose = widget.purpose;
  }

  @override
  Widget build(BuildContext context) {
    
    int selectedIndex = widget.selectedCategory;
    return BlocProvider(
      // value: widget.mainCategoryBloc..add(SelectedLevelOneCat(widget.selectedCategory)),
      create: (context) => MainCategoryBloc(widget.purpose)..add(SelectedLevelOneCat(widget.selectedCategory)),
      child: BlocConsumer<MainCategoryBloc, MainCategoryState>(
        listener: (context, state) {
          if (state is ShowLevelThreeSubCategory) {
            switchPage(1, _pageController);
          }else if(state is BackToFirstPage){
            _selectedL2SubCatName = null;
            _selectedL3SubCatName = null;
            switchPage(0, _pageController);
          }else if(state is PushOrPopToScreen){
            if(state.navigationMode == SelectedNavigationMode.push){
              Navigator.pushNamed(context,state.routName);
              Future.delayed(const Duration(milliseconds: 800)).then((value){//after navigate to new screen change selected item into unselected
                _selectedL2SubCatName = _selectedL3SubCatName = null;
                context.read<MainCategoryBloc>().add(const DoExtraEvent(eventType: EventAction.refreshPage));
              });
            }else{
              Navigator.pop(context,state.routName);
            }
          }else if(state is ShowLevelTwoSubCategory || state is ComingsoonMainCategory){
            if (widget.purpose == CategoryBottomSheetPurpose.forSearcinghAd) {
              HomePageScreen.selectMainCategory.value = state.props.first as int;
            }
          }
        },
        builder: (context, state) {
          if (state is ShowLevelTwoSubCategory) {
            _levelTwoSubCatList = state.level2SubCategoryList;
            selectedIndex = state.index;            
          }else if(state is ShowLevelThreeSubCategory){
            _levelThreeSubCatList = state.level3SubCategoryList;
          }else if(state is ComingsoonMainCategory){
            selectedIndex = state.index;
          }
          return Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.all(Radius.circular(kpadding10))),
            width: double.infinity,
            height: 300,
            child: LayoutBuilder(
              builder: (ctx, cons) => PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  //  firstpage:  Real estate category
                  _firstPageLevelTwoCat(
                    cons: cons,
                    context: context,
                    selectedIndex: selectedIndex,
                    state: state,
                  ),

                  //  secondpage: subcategory under Building for sale sub_category
                  _secondPageLevelThreeCat(
                    cons: cons, 
                    state: state,
                    context: context
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Stack _secondPageLevelThreeCat({
    required BoxConstraints cons,
    required  MainCategoryState state,
    required BuildContext context,
    }) {
    return Stack(
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
                            children: List.from(_levelThreeSubCatList.map((subCat) => InkWell(
                              child: Container(
                                width: cons.maxWidth / 3,
                                height: cons.maxHeight / 3 + 25,
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                foregroundDecoration: (_selectedL3SubCatName ?? '') == subCat['cat_name']!
                                  ? null
                                  : const BoxDecoration(
                                      color: Colors.grey,
                                      backgroundBlendMode: BlendMode.saturation,
                                    ),
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
                                _selectedL3SubCatName = subCat['cat_name'];
                                context.read<MainCategoryBloc>().add(SelectedLevelThreeCat(subCat['root_name']));
                              },
                            ))),
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
              context.read<MainCategoryBloc>().add(const DoExtraEvent(eventType: EventAction.goToPageOne));
            },
          ),
        ),
      ],
    );
  }

  SizedBox _firstPageLevelTwoCat(
      {required BoxConstraints cons,
      required BuildContext context,
      required int selectedIndex,
      required MainCategoryState state}) {
    return SizedBox(
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
                  return MainCategoryIconWithName(
                    selectedCategory: selectedIndex,
                    size: 90,
                    index: index,
                    onTap: (mainCategory) {
                      context.read<MainCategoryBloc>().add(SelectedLevelOneCat(index));
                    },
                  );
                }),
          ),
          DashedLineGenerator(width: cons.maxWidth),
          //  Sub category under real-estate category
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: kpadding10),
                physics: const BouncingScrollPhysics(),
                child: state is ComingsoonMainCategory
                    ? LottieWidget.comingsoon()
                    : Wrap(
                            runSpacing: kpadding10,
                            spacing: 5,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceAround,
                            runAlignment: WrapAlignment.center,
                            children: List.from(
                                _levelTwoSubCatList.map((subCate) => InkWell(
                                      onTap: () {
                                        _selectedL2SubCatName = subCate['cat_name'];
                                        // if(subCate['cat_name'] != 'COMMING SOON'){
                                        //   if(subCate['end_of_cat'] == true){
                                        //     Navigator.of(context).pushNamed(subCate['root_name']);
                                        //   }else{
                                        //     subCategoryNotifier.value = subCate['next_cat_list'];
                                        //     switchPage(1, pageController);
                                        //   }
                                        // }
                                        context.read<MainCategoryBloc>().add(SelectedLevelTwoCat(subCate));
                                        
                                      },
                                      child: subCategoryGreyContainer(cons, subCate['cat_name']),
                                    ))),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container subCategoryGreyContainer(BoxConstraints cons, String subCate) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // width: cons.maxWidth*0.45,
      constraints: BoxConstraints(
        minWidth: cons.maxWidth * 0.3,
        maxWidth: cons.maxWidth,
        minHeight: 35,
      ),
      decoration: BoxDecoration(
        color: kDisabledBackground,
        borderRadius: const BorderRadius.all(Radius.circular(30),),
        border: (_selectedL2SubCatName ?? '') == subCate ? Border.all(color: kPrimaryColor) : null,
      ),
      child: Text(
        subCate,
        style: TextStyle(
          color: (_selectedL2SubCatName ?? '') == subCate ? kPrimaryColor : kDisabledText,
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
