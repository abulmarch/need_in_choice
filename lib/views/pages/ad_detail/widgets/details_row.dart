import 'package:flutter/material.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import 'land_widget.dart';

class DetailsRow extends StatelessWidget {
  const DetailsRow({
    Key? key,
    required this.details,
  }) : super(key: key);

  final Map<String, dynamic> details;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: kWhiteColor.withOpacity(.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bolt,
              color: kWhiteColor,
            ),
          ),
          kWidth10,
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: details.length,
              itemBuilder: (BuildContext context, int index) {
                var key = details.keys.toList()[index];
                var value = details.values.toList()[index];

                return LandWidget(
                  value: value is String ? value : value['value'],
                  name: key,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return vericalDivider;
              },
            ),
          ),
        ],
      ),
    );
  }
}
