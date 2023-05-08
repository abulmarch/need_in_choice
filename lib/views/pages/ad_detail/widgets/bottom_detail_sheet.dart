import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'details_row.dart';
import '../../../widgets_refactored/icon_button.dart';

class BottomDetailsSheet extends StatelessWidget {
  const BottomDetailsSheet({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(

      initialChildSize: .3,
      minChildSize: .3,
      maxChildSize: .8,
      builder: (BuildContext context, ScrollController scrollController) {
        return ListView.builder(
          itemCount: 1,
          controller: scrollController,
          itemBuilder: (context, index) {
            return Container(
              width: screenWidth,
              height: screenHeight * .8,
              decoration: BoxDecoration(
                color: bottomSheetcolor.withOpacity(.96),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kpadding15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("Modern Restaurant aluva",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                        kWidth5,
                        const Icon(
                          Icons.favorite_border_outlined,
                          color: kWhiteColor,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: kWhiteColor,
                        ),
                        kWidth5,
                        Text(
                          'Karmana Trivandrum Kerala',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                    kHeight10,
                    const Text(
                      '------------------------------------------',
                      style: TextStyle(height: 0.7, color: kDottedBorder),
                    ),
                    const DetailsRow(),
                    kHeight10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "₹",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 19),
                            children: [
                              TextSpan(
                                text: " 98000",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 28),
                              ),
                              TextSpan(
                                text: "/-",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                        kWidth10,
                        IconWithButton(
                          onpressed: () {},
                          iconData: Icons.rocket_launch_outlined,
                          text: "Chat Now",
                          radius: 10,
                          size: const Size(180, 50),
                        )
                      ],
                    ),
                    kHeight20,
                    const Text(
                      '------------------------------------------',
                      style: TextStyle(height: 0.7, color: kPrimaryColor),
                    ),
                    kHeight10,
                    const DetailsRow(),
                    kHeight10,
                    const Text(
                      '------------------------------------------',
                      style: TextStyle(height: 0.7, color: kPrimaryColor),
                    ),
                    kHeight10,
                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    Expanded(
                      child: Text(
                        'Kalyan Gateway is our new upcoming luxury apartment project in Trivandrum. Located at NH Bypass, in close proximity to the IT Technopark and the upcoming Lulu Mall, these 2 and 3 BHK luxury flats are ideal for the increasing young and vibrant crowd in the city.',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 13,
                                  color: const Color(0XFF878181),
                                ),
                      ),
                    ),
                    const Text(
                      '------------------------------------------',
                      style: TextStyle(height: 0.7, color: kPrimaryColor),
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Near PRS Hospital",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: 13,
                                    color: const Color(0XFF878181)),
                            children: [
                              TextSpan(
                                text: "\nwww.calletic.com",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    kHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconWithButton(
                          onpressed: () {},
                          text: "Give a Call",
                          iconData: Icons.phone,
                          radius: 100,
                          size: const Size(100, 51),
                        ),
                        IconWithButton(
                          background: Colors.green,
                          onpressed: () {},
                          text: "Message Me",
                          iconData: Icons.message,
                          radius: 100,
                          size: const Size(100, 51),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
