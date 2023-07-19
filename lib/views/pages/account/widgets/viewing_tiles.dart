import 'package:flutter/material.dart';
import 'package:need_in_choice/services/model/ads_models.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class ViewingTiles extends StatelessWidget {
  
  const ViewingTiles({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kadBox,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 88,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            kWidth5,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: kDarkGreyColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
            kWidth5,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Modern Contrepersist",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: const Color(0xff606060),
                        ),
                  ),
                  kHeight5,
                  const Text(
                    '-------------------------',
                    style: TextStyle(height: 0.7, color: kDottedBorder),
                  ),
                  kHeight10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      kWidth5,
                      Text(
                        "₹90,000",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 10),
                      ),
                      const VerticalDivider(
                        color: kDarkGreyColor,
                        thickness: 5,
                        width: 10,
                        indent: 20,
                        endIndent: 0,
                      ),
                      Container(
                        height: 20,
                        width: 80,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            'Active',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 10),
                          ),
                        ),
                      ),
                      kWidth5,
                    ],
                  ),
                ],
              ),
            ),
            kWidth5,
          ],
        ),
      ),
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
}
