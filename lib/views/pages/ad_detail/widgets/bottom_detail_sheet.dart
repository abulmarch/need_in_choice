import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class BottomDetailsSheet extends StatelessWidget {
  const BottomDetailsSheet({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .3,
      minChildSize: .2,
      maxChildSize: .7,
      builder:
          (BuildContext context, ScrollController scrollController) {
        return Container(
          width: screenWidth,
          decoration: BoxDecoration(
            color: bottomSheetcolor.withOpacity(.96),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kpadding20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("Modern Restaurant aluva",
                      maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleLarge),
                    ),
                    kWidth5,
                    const Icon(Icons.favorite_border_outlined, color: kWhiteColor,)
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: kWhiteColor,),
                    Text('Karmana Trivandrum Kerala', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 15),)
                  ],
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
