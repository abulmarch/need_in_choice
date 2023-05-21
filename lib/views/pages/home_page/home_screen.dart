import 'package:flutter/material.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/utils/constants.dart';
import 'package:need_in_choice/views/pages/home_page/show_category_bottomsheet.dart';
import '../../../utils/category_data.dart';
import '../../../utils/colors.dart';
import '../../../utils/dummy_data.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/rich_text_builder.dart';
import '../../widgets_refactored/search_form_field.dart';
import 'widgets.dart/advertisement_card_widget.dart';
import 'widgets.dart/scrolling_category.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints cons) => NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leadingWidth: 0,
                    elevation: 0,
                    leading: const SizedBox(),
                    toolbarHeight: 66,
                    title: innerBoxIsScrolled
                        ? const SizedBox(
                            height: kToolbarHeight,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: SearchFormField(
                                hintText: 'Find vehicle, furniture and more',
                              ),
                            ),
                          )
                        : const SizedBox(),
                    floating: true,
                    pinned: true,
                    backgroundColor: Colors.white,
                    expandedHeight: 320,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            // top avatar card
                            buyAndSellAnything(context),
                            //category listing
                            whatAreYouLokkingFor(context, cons),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: SizedBox(
                width: cons.maxWidth,
                height: cons.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                  child: LayoutBuilder(builder: (ctx, bC) {
                    double imageSize = bC.maxWidth * 0.5 -
                        15; // subtract padding form half of width

                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.70,
                      ),
                      itemCount: 8,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius:
                              BorderRadius.all(Radius.circular(kpadding10)),
                        ),
                        child: Column(
                          children: [
                            // ad images and posted time
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, adDetailScreen);
                              },
                              child: AdvertisementWidget(
                                imageSize: imageSize,
                                phouseFoRentr: houseFoRentAd,
                              ),
                            ),

                            //  ad details under the image
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Modern Contrper',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: kFadedBlack,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                15), //TextStyle(color: kFadedBlack),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: addDetails.length,
                                      itemBuilder: (context, index) =>
                                          RichTextBuilder.firstWord(
                                              text: addDetails[index]
                                                  .toUpperCase()),
                                      separatorBuilder: (context, index) =>
                                          const VerticalDivider(
                                        color: kDottedBorder,
                                        thickness: 1,
                                        endIndent: 8,
                                        indent: 2,
                                        width: 5,
                                      ),
                                    ),
                                  ),
                                  DashedLineGenerator(width: imageSize),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: kGreyColor,
                                        size: 18,
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: RichTextBuilder.firstWord(
                                          text: 'Technopark Trivandr'
                                              .toUpperCase(),
                                          fontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                            text: '₹',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: kFadedBlack),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '19950/-',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: kFadedBlack))
                                            ]),
                                      ),
                                      const CircleAvatar(
                                        maxRadius: 10,
                                        backgroundImage: AssetImage(
                                            'assets/images/profile/no_profile_img.png'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ));
  }

  Widget buyAndSellAnything(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: 140,
          margin:
              const EdgeInsets.only(bottom: kpadding10 * 3, left: 5, right: 5),
          padding: const EdgeInsets.all(kpadding15),
          decoration: BoxDecoration(
            color: kLightBlueWhite,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(kpadding10),
                bottomRight: Radius.circular(kpadding10)),
            border: Border.all(color: kLightBlueWhiteBorder, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: kpadding10),
                          child: DropdownButton<String>(
                            menuMaxHeight: 250,
                            value: 'Trivandrum',
                            underline: const SizedBox(),
                            icon: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: const Icon(Icons.keyboard_arrow_down,
                                  color: Color(0xFF736F6F), size: 17),
                            ),
                            elevation: 8,
                            isDense: true,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF736F6F)),
                            onChanged: (String? value) {},
                            items: cityName
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const Text(
                          '------------------',
                          style: TextStyle(height: 0.7, color: kDottedBorder),
                        )
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Buy &',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: const Color(0xFF484848)),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sell \nAnything Now',
                              // style: TextStyle(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    height: 0.9,
                                  )),
                          TextSpan(
                              text: '...',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: const Color(0xFF898989),
                                      height: 0.9)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, accountScreen);
                    },
                    child: const CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/profile/no_profile_img.png'),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Account ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 9, color: const Color(0xFF6A6A6A)),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Details',
                          style: TextStyle(color: Color(0xFF1C8FFB)),
                        ),
                        TextSpan(
                            text: '\nView more info',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 8,
                                    color: const Color(0xFFBABABA))),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kpadding20),
          child: SearchFormField(
            hintText: 'Find vehicle, furniture and more',
          ),
        ),
      ],
    );
  }

  Container whatAreYouLokkingFor(
      BuildContext context, BoxConstraints constraints) {
    return Container(
      key: UniqueKey(),
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(kpadding15),
      // color: Colors.pink[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What are you looking for?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF484848)),
              ),
              TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(5, 5)),
                    alignment: Alignment.topCenter,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Text(
                        'See all',
                        style: TextStyle(fontSize: 14),
                      ),
                      RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_drop_down_circle_rounded,
                          ))
                    ],
                  )),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints bConst) {
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCategories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return MainCategoryIconWithName(
                      selectedCategory: -1, 
                      size: bConst.maxHeight,
                      index: index,
                      onTap: () {
                        if(mainCategories[index]['is_comming_soon']!=null){
                          showModalBottomSheet(
                            context: context, 
                            builder: (context) => ShowCatogoryBottomSheet(level2SubCat: mainCategories[index]['next_cat_list'],selectedMainCatIndex: index),
                            backgroundColor: Colors.white.withOpacity(0),
                            enableDrag: false,
                          );
                        }else if(mainCategories[index]['end_of_cat'] == true){
                          Navigator.of(context).pushNamed(mainCategories[index]['root_name']);
                        }else{
                          showModalBottomSheet(
                            context: context, 
                            builder: (context) => ShowCatogoryBottomSheet(level2SubCat: mainCategories[index]['next_cat_list'],selectedMainCatIndex: index),
                            backgroundColor: Colors.white.withOpacity(0),
                            enableDrag: false,
                          );
                        }
                      },
                    );
                  }
                )
              );
            }),
          ),
          DashedLineGenerator(
            width: constraints.maxWidth - 30,
          )
        ],
      ),
    );
  }
}
