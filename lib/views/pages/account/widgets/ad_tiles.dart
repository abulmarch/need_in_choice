import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need_in_choice/services/model/ads_models.dart';
import 'package:need_in_choice/views/pages/account/ad_card_cubit/ad_card_cubit.dart';
import '../../../../blocs/ad_create_or_update_bloc/ad_create_or_update_bloc.dart';
import '../../../../config/theme/screen_size.dart';
import '../../../../services/repositories/repository_urls.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../widgets_refactored/dashed_line_generator.dart';
import 'edit_button.dart';
import 'stripe_payment.dart';

class Adtiles extends StatelessWidget {
  final AdsModel adsModel;
  const Adtiles({
    super.key,
    required this.adsModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = ScreenSize.size.width;

    AdsModel adsData = adsModel;
    DateTime expirationDate = DateTime.parse(adsData.expiratedDate);
    bool isExpired = expirationDate.isBefore(DateTime.now());
    final menuItems = ['Mark as sold'];
    return BlocBuilder<AdCardCubit, AdCardState>(
      builder: (context, state) {
        if (state is AdCardError) {
            showSnackBar(context: context,msg: 'Something went wrong. Please try again.');
        }else if(state is AdCardDataUpdated){
          adsData = state.updatedAd;
          expirationDate = DateTime.parse(adsData.expiratedDate);
          isExpired = expirationDate.isBefore(DateTime.now());
          showSnackBar(context: context,msg: state.msg);
        }
        return Card(
          color: kadBox,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 138,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                kWidth5,
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundDecoration: isExpired? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.6),
                              ): null,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(kpadding10)),
                                child: CachedNetworkImage(
                                  imageUrl: adsData.images.isNotEmpty? "$imageUrlEndpoint${adsData.images.first}" : '',
                                  placeholder: (context, url) => const Icon(
                                    Icons.image,
                                    size: 30,
                                    color: kLightGreyColor,
                                  ),
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.image,
                                    size: 30,
                                    color: kLightGreyColor,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )
                            ),
                          adsData.isPremium ? const Positioned(
                            top: 3,
                            left: 3,
                            child: Icon(Icons.verified,size: 20,color: kPrimaryColor,)
                          ) : const SizedBox(),
                        ],
                      ),
                      kHeight5,
                      adStatusDetails(disabled: isExpired, context: context),
                    ],
                  ),
                ),
                kWidth20,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * 0.46,
                            child: Text(
                              adsData.adsTitle,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: const Color(0xff606060),
                                  ),
                            ),
                          ),
                          const Spacer(),
                          PopupMenuButton(
                            icon: const CircleAvatar(
                                maxRadius: 10,
                                backgroundColor: kPrimaryColor,
                                child: CircleAvatar(
                                    maxRadius: 9,
                                    backgroundColor: kadBox,
                                    child: Icon(
                                      Icons.more_vert,
                                      color: kPrimaryColor,
                                      size: 12,
                                    ))),
                            color: Colors.white,
                            position: PopupMenuPosition.under,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints.tightFor(
                              width: 150,
                            ),
                            itemBuilder: (BuildContext context) => menuItems
                                .asMap()
                                .entries
                                .map(
                                  (e) => PopupMenuItem(
                                    textStyle: Theme.of(context).textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 12,
                                            color: kPrimaryColor.withOpacity(0.6)),
                                    onTap: () {
                                      showLoadingSnackBar(context);
                                      context.read<AdCardCubit>().markAsSold(adsData);
                                    },
                                    child: Text(e.value),
                                  ),
                                )
                                .toList(),
                          ),
                          // kWidth5,
                        ],
                      ),
                      kHeight5,
                      SizedBox(
                        width: width * .5,
                        child: const MySeparator(color: kDottedBorder),
                      ),
                      kHeight10,
                      Row(
                        children: [
                          viewItem(
                            context,
                            icon: Icons.remove_red_eye_outlined,
                            text: 'Views',
                            count: 0,
                          ),
                          kWidth5,
                          const SizedBox(
                            height: 15,
                            child: VerticalDivider(
                              color: kLightGreyColor,
                              thickness: 1,
                              width: 1,
                            ),
                          ),
                          kWidth5,
                          viewItem(
                            context,
                            icon: Icons.favorite,
                            text: 'Likes',
                            count: 0,
                          ),
                        ],
                      ),
                      kHeight10,
                      Container(
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              EditButton(
                                boxcolor: kadBox,
                                height: 23,
                                width: 71,
                                text: isExpired ? "Renew" : "Edit Ad",
                                textcolor: isExpired
                                    ? kDarkGreyColor.withOpacity(.8)
                                    : kPrimaryColor,
                                ontap: () {
                                  BlocProvider.of<AdCreateOrUpdateBloc>(context).add(SwitchToInitialStateEvent());
                                  Navigator.pushNamed(context, adsData.routeName, arguments: adsData.id);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                                child: VerticalDivider(
                                  color: kLightGreyColor,
                                  thickness: 1,
                                  width: 1,
                                ),
                              ),
                              EditButton(
                                boxcolor: kPrimaryColor,
                                height: 23,
                                width: 100,
                                text: "Get Premium",
                                textcolor: kWhiteColor,
                                ontap: () {
                                  _showPremiumPlanBottomSheet(context, adsData);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                kWidth5,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget adStatusDetails(
      {required bool disabled, required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 20,
          width: 80,
          decoration: BoxDecoration(
            color: disabled ? kPrimaryColor.withOpacity(.42) : kPrimaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              disabled ? 'Expired' : 'Active',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 10),
            ),
          ),
        ),
        RichText(
          text: TextSpan(
              text: "The Ad is\n",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontSize: 8,
                  color: disabled
                      ? kPrimaryColor.withOpacity(.42)
                      : kPrimaryColor.withOpacity(.42)),
              children: [
                TextSpan(
                    text: disabled ? "currently expired" : "currently live",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 8,
                        color: disabled
                            ? kPrimaryColor.withOpacity(.42)
                            : kPrimaryColor))
              ]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Row viewItem(BuildContext context,
      {IconData? icon, String? text, int? count}) {
    return Row(
      children: [
        Icon(
          icon,
          color: kDottedBorder,
          size: 20,
        ),
        kWidth5,
        Text(
          '$text : $count',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 9, color: kDottedBorder),
        ),
      ],
    );
  }
  
  Future<void> showSnackBar({required BuildContext context, required String msg}) async{
    Future.delayed(Duration.zero,() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(msg,),
        ),
      );
    },);
  }
  Future<void> showLoadingSnackBar(BuildContext context) async{
    Future.delayed(Duration.zero,() {
      SnackBar snackBar = const SnackBar(
        content: LinearProgressIndicator(),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF00000e),
        duration: Duration(hours: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

  }
}

void _showPremiumPlanBottomSheet(BuildContext ctx, AdsModel adsData) {
  showModalBottomSheet(
    elevation: 10,
    backgroundColor: Colors.transparent,
    context: ctx,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return StripePremium(
        adCardCubit: ctx.read<AdCardCubit>(),
        adsModel: adsData,
        amount: 99,
      );
    },
  );
}
