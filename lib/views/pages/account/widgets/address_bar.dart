import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class AddressBar extends StatelessWidget {
  final Function() ontap;
  const AddressBar({
    super.key,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    bool buttonPressed = false;
    return Container(
      width: double.infinity,
      height: 170,
      margin: const EdgeInsets.only(
        top: 5,
        bottom: kpadding10 * 3,
        left: 5,
        right: 5,
      ),
      padding: const EdgeInsets.all(kpadding10),
      decoration: BoxDecoration(
        color: kLightBlueWhite,
        borderRadius: const BorderRadius.all(
          Radius.circular(kpadding10),
        ),
        border: Border.all(color: kLightBlueWhiteBorder, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: kWhiteColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'P Mathew Varghese',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              kHeight5,
              Text(
                'Calletic Technologies Pvt Ltd 4th Floor, \n Nila, Technopark Campus, Technopark\nCampus, Kazhakkoottam,\nThiruvananthapuram, Kerala 695581',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 12),
              ),
            ],
          ),
          Column(
            children: [
              const CircleAvatar(
                maxRadius: 40,
                backgroundImage:
                    AssetImage('assets/images/profile/no_profile_img.png'),
              ),
              kHeight5,
              GestureDetector(
                onTap: ontap,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.favorite_outline,
                          color: kWhiteColor,
                        ),
                        Text(
                          "view",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: kWhiteColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
