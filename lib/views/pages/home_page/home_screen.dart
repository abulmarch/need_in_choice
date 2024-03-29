import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/blocs/main_category_bloc/main_category_bloc.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/services/model/account_model.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import 'package:need_in_choice/utils/constants.dart';
import '../../../blocs/all_ads_bloc/all_ads_bloc.dart';
import '../../../config/theme/screen_size.dart';
import '../../../services/repositories/notification_service.dart';
import '../../../services/repositories/repository_urls.dart';
import '../../../utils/category_data.dart';
import '../../../utils/colors.dart';
import '../../widgets_refactored/dashed_line_generator.dart';
import '../../widgets_refactored/lottie_widget.dart' show LottieWidget;
import '../../widgets_refactored/rich_text_builder.dart';
import '../../widgets_refactored/search_form_field.dart';
import '../login/bloc/auth_bloc.dart';
import 'location_select.dart';
import 'show_category_bottomsheet.dart';
import 'widgets.dart/advertisement_card_widget.dart';
import 'widgets.dart/scrolling_category.dart';





class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  static late ValueNotifier<int> selectMainCategory;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

NotificationServices notificationServices = NotificationServices();

  late FocusNode _secondTextFieldFocus;
  late ScrollController _scrollController;
  late ValueNotifier<bool> _searchbarNotifier;
  late ValueNotifier<ScrollPhysics> _physicsNotifier;
  late TextEditingController _searchTextController;
  AccountModels accountModels = AccountSingleton().getAccountModels;
  
  
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchbarNotifier = ValueNotifier(false);
    _physicsNotifier = ValueNotifier(const NeverScrollableScrollPhysics());
    HomePageScreen.selectMainCategory = ValueNotifier(-1);
    _searchTextController = TextEditingController();
    _secondTextFieldFocus = FocusNode();
    scrollControllerListener();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.forgroundMessage();
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    
    notificationServices.getDeviceToken().then((value) {
        log('device token $value');
    });
  }

  scrollControllerListener() {
    _scrollController.addListener(
      () {
        if (_searchbarNotifier.value == false) {
          if (_scrollController.positions.first.maxScrollExtent - 50 < _scrollController.positions.first.pixels) {
            _searchbarNotifier.value = true;
          }
        } else {
          if (_scrollController.positions.first.maxScrollExtent - 50 > _scrollController.positions.first.pixels) {
            _searchbarNotifier.value = false;
          }
        }
        if (_scrollController.positions.last.maxScrollExtent == 0) {
          return;
        }
        if (_physicsNotifier.value is NeverScrollableScrollPhysics) {
          if ((_scrollController.positions.first.maxScrollExtent == _scrollController.positions.first.pixels) &&
              _scrollController.positions.last.maxScrollExtent != 0 && _scrollController.positions.last.userScrollDirection == ScrollDirection.idle &&
              _scrollController.positions.last.atEdge == true) {
            _physicsNotifier.value = const BouncingScrollPhysics();
          }
        } else {
          if (_scrollController.positions.last.pixels < 30 && _scrollController.positions.last.userScrollDirection == ScrollDirection.forward) {
            _physicsNotifier.value = const NeverScrollableScrollPhysics();
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          }
        }
        if (_scrollController.positions.last.outOfRange == true && _scrollController.positions.last.activity != null &&
            _scrollController.positions.last.activity!.velocity < -300 && _scrollController.positions.last.userScrollDirection ==  ScrollDirection.reverse) {
          if (context.read<AllAdsBloc>().state is AllAdsLoaded) {
            BlocProvider.of<AllAdsBloc>(context).add(FetchNextPage());
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        // key: const PageStorageKey<String>('mySliverAppBar'),
        builder: (BuildContext ctx, BoxConstraints cons) => RefreshIndicator(
              onRefresh: () async {
                if (BlocProvider.of<AllAdsBloc>(context).state
                    is! InitialLoading) {
                  BlocProvider.of<AllAdsBloc>(context)
                      .add(RefreshPageAndFetchAds());
                }
              },
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leadingWidth: 0,
                      elevation: 0,
                      leading: const SizedBox(),
                      toolbarHeight: 66,
                      title: ValueListenableBuilder(
                          valueListenable: _searchbarNotifier,
                          builder: (context, value, _) {
                            return value
                                ? SizedBox(
                                    height: kToolbarHeight,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: SearchFormField(
                                        focusNode: _secondTextFieldFocus,
                                        controller: _searchTextController,
                                        hintText:
                                            'Find vehicle, furniture and more',
                                        onFieldSubmitted: (word) {
                                          context.read<AllAdsBloc>().add(
                                              SearchAllAds(
                                                  typeOfFetching:
                                                      AdsFetchingType
                                                          .fetchSearchedAds,
                                                  searchingWord: word));
                                        },
                                      ),
                                    ),
                                  )
                                : const SizedBox();
                          }),
                      floating: true,
                      pinned: true,
                      backgroundColor: Colors.white,
                      expandedHeight: 320,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SizedBox(
                          width: ScreenSize.size.width,
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
                  // key: const PageStorageKey<String>('mySizedBox'),
                  width: cons.maxWidth,
                  height: cons.maxHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kpadding15),
                    child: LayoutBuilder(builder: (ctx, bC) {
                      double imageSize = bC.maxWidth * 0.5 -
                          15; // subtract padding form half of width
                      return BlocBuilder<AllAdsBloc, AllAdsState>(
                        builder: (context, state) {
                          if (state is InitialLoading) {
                            //state is AllAdsLoding ||
                            return LottieWidget.loading();
                          } else {
                            List<AdsModel> adsList = [];
                            bool isLoading = false;
                            if (state is AllAdsLoaded) {
                              adsList = state.adsList;
                              if (state.backToFetchAllAdsEvent) {
                                Future.delayed(Duration.zero).then((value) => _searchTextController.clear());
                              }
                            } else if (state is NextPageLoading) {
                              adsList = state.oldAdsList;
                              isLoading = true;
                            }
                            if (adsList.isEmpty) {
                              return LottieWidget.noData();
                            }
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                GridView.builder(
                                    controller: _scrollController,
                                    // key: const PageStorageKey<String>('myListView'),
                                    physics: _physicsNotifier.value,
                                    itemCount:
                                        adsList.length + (isLoading ? 1 : 0),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      childAspectRatio: 0.70,
                                    ),
                                    itemBuilder: (context, index) {
                                      if (index < adsList.length) {
                                        return _gridViewCard(
                                            context, imageSize, adsList[index]);
                                      } else {
                                        return const Center(
                                          child: SizedBox(),
                                        );
                                      }
                                    }),
                                SizedBox(
                                  height: cons.maxHeight * 0.3,
                                  width: double.maxFinite,
                                  child: isLoading
                                      ? LottieWidget.loading(
                                          size: 100,
                                        )
                                      //  const Center(
                                      //     child: CircularProgressIndicator(),
                                      //   )
                                      : null,
                                ),
                              ],
                            );
                          }
                        },
                      );
                    }),
                  ),
                ),
              ),
            ));
  }

  Container _gridViewCard(
      BuildContext context, double imageSize, AdsModel adsModel) {
    Map primaryDetails = adsModel.categoryInfo['primary_details'];
    String adPrice = '';

    if (adsModel.adPrice is Map) {
      if (adsModel.adPrice.containsKey('Start Price')) {
        adPrice = adsModel.adPrice['Start Price'].toString();
      } else if (adsModel.adPrice.containsKey('Monthly')) {
        adPrice = adsModel.adPrice['Monthly'].toString();
      }
    } else if (adsModel.adPrice is String) {
      adPrice = adsModel.adPrice;
    }
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.all(Radius.circular(kpadding10)),
      ),
      child: Column(
        children: [
          // ad images and posted time
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, adDetailScreen,
                  arguments: adsModel.id);
            },
            child: AdvertisementWidget(
              imageSize: imageSize,
              adsImageUrlList: adsModel.images,
              timeAgo: adsModel.timeAgo,
              isPremium: adsModel.isPremium,
            ),
          ),

          //  ad details under the image
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adsModel.adsTitle, //'Modern Contrper',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: kFadedBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: 15), //TextStyle(color: kFadedBlack),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 20,
                  child: ListView.separated(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // itemCount: primaryDataList.length,
                    itemCount: primaryDetails.length,
                    itemBuilder: (context, index) {
                      // return SizedBox();
                      // primaryDetails.entries.first.;
                      return RichTextBuildFromMap(
                          mapEntry: primaryDetails.entries.elementAt(index));
                      // RichTextBuilder.firstWord(//  primaryDetails['primary_details']
                      //     text: primaryDataList[index]//addDetails
                      //         .toUpperCase())
                    },
                    separatorBuilder: (context, index) => const VerticalDivider(
                      color: kDottedBorder,
                      thickness: 1,
                      endIndent: 8,
                      indent: 2,
                      width: 5,
                    ),
                  ),
                ),
                SizedBox(
                    width: imageSize,
                    child: const MySeparator(
                      color: kDottedBorder,
                    )),
                //DashedLineGenerator(width: imageSize),
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
                        text: '${adsModel.categoryInfo['ads_address']}'
                            .toUpperCase(), //'Technopark Trivandr'
                        fontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    adPrice.isNotEmpty
                        ? RichText(
                            text: TextSpan(
                                text: '₹',
                                style: const TextStyle(
                                    fontSize: 13, color: kFadedBlack),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '$adPrice/-', //'19950123/-',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: kFadedBlack))
                                ]),
                          )
                        : const SizedBox(
                            width: 20,
                          ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, accountScreen);
                      },
                      child: CircleAvatar(
                        maxRadius: 13,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            child: CachedNetworkImage(
                              imageUrl: "$imageUrlEndpoint${adsModel.profileImage}",
                              placeholder: (context, url) => Image.asset('assets/images/profile/no_profile_img.png'),
                              errorWidget: (context, url, error) => Image.asset('assets/images/profile/no_profile_img.png'),
                              fit: BoxFit.cover,
                              height: 26,width: 26,
                            ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buyAndSellAnything(BuildContext context) {
    final double screenWidth = ScreenSize.size.width;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: 150,
          margin:
              const EdgeInsets.only(bottom: kpadding10 * 3, left: 5, right: 5),
          padding: const EdgeInsets.all(kpadding15),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(kpadding10),
                bottomRight: Radius.circular(kpadding10)),
            border: Border.all(color: kLightBlueWhiteBorder, width: 1.5),
            image: const DecorationImage(
              image: AssetImage('assets/images/dummy/Rectangle.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoggedIn) {
                accountModels = state.accountModels;
              }
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            InkWell(
                              onTap: () {
                                _openLocationBottomSheet();
                              },
                              child: SizedBox(
                                height: 30,
                                width: screenWidth * .5,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        accountModels.selectedPlace ?? 'Location',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF736F6F)),overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      size: 20,
                                      color: Color(0xFF736F6F),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width: screenWidth * 0.5,
                                child: const MySeparator(
                                  color: kDottedBorder,
                                ))
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Buy & ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: const Color(0xFF484848)),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sell',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Everything Now',
                            style: Theme.of(context).textTheme.headlineSmall!,
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ...',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      color: const Color(0xFF898989),
                                      height: 0.9,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, accountScreen);
                        },
                        child: CircleAvatar(
                          maxRadius: 30,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            child: CachedNetworkImage(
                              imageUrl: "$imageUrlEndpoint${accountModels.profileImage}",
                              placeholder: (context, url) => Image.asset('assets/images/profile/no_profile_img.png'),
                              errorWidget: (context, url, error) => Image.asset('assets/images/profile/no_profile_img.png'),
                              fit: BoxFit.cover,
                              height: 60,width: 60,
                            ),
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Account ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
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
              );
            },
          ),
        ),
        ValueListenableBuilder(
            valueListenable: _searchbarNotifier,
            builder: (context, value, _) {
              return !value
                  ? Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kpadding20),
                      child: InkWell(
                        onTap: _searchFieldClicked,
                        child: SearchFormField(
                          controller: _searchTextController,
                          enabled: false,
                          hintText: 'Find vehicle, furniture and more',
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: kToolbarHeight,
                    );
            }),
      ],
    );
  }

  Container whatAreYouLokkingFor(
      BuildContext context, BoxConstraints constraints) {
    return Container(
      key: UniqueKey(),
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.symmetric(
          horizontal: kpadding15, vertical: kpadding10),
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
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF484848)),
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints bConst) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: mainCategories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder<int>(
                        valueListenable: HomePageScreen.selectMainCategory,
                        builder: (context, selectedIndex, _) {
                          return MainCategoryIconWithName(
                            selectedCategory: selectedIndex,
                            size: bConst.maxHeight,
                            index: index,
                            onTap: (mainCategory) async {
                              HomePageScreen.selectMainCategory.value = index;
                              showModalBottomSheet<String?>(
                                context: context,
                                builder: (context) => ShowCatogoryBottomSheet(
                                  purpose:
                                      CategoryBottomSheetPurpose.forSearcinghAd,
                                  selectedCategory: index,
                                ),
                                backgroundColor: Colors.white.withOpacity(0),
                                enableDrag: false,
                              ).then((searchingWord) {
                                if (searchingWord == null) {
                                  if (context
                                          .read<AllAdsBloc>()
                                          .indexOfMainCatForSort ==
                                      -1) {
                                    HomePageScreen.selectMainCategory.value =
                                        -1;
                                  } else {
                                    HomePageScreen.selectMainCategory.value =
                                        context
                                            .read<AllAdsBloc>()
                                            .indexOfMainCatForSort;
                                  }
                                } else {
                                  context.read<AllAdsBloc>().add(
                                      SortAdsByCategory(
                                          categoryEndRoute: searchingWord,
                                          selectedMainCat: mainCategory,
                                          typeOfFetching:
                                              AdsFetchingType.fetchSortedAds));
                                }
                              });
                            },
                          );
                        });
                  });
            }),
          ),
          DashedLineGenerator(
            width: constraints.maxWidth - 30,
          )
        ],
      ),
    );
  }

  void _openLocationBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        reverse: false,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const LocationSheet(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _physicsNotifier.dispose();
    _scrollController.dispose();
    _searchbarNotifier.dispose();
    _secondTextFieldFocus.dispose();
    HomePageScreen.selectMainCategory.dispose();
    _searchTextController.dispose();
  }

  void _searchFieldClicked() {
    log('loglog   _scrollController.positions.first.maxScrollExtent : ${_scrollController.positions.first.maxScrollExtent}');
    _scrollController
        .animateTo(_scrollController.positions.first.maxScrollExtent,
            duration: const Duration(milliseconds: 400), curve: Curves.easeInCubic)
        .then((value) {
      log('loglog   _scrollController.positions.first.pixels : ${_scrollController.positions.first.pixels}');
      _secondTextFieldFocus.requestFocus();
    });
  }
}
