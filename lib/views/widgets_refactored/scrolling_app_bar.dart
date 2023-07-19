import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'circular_back_button.dart';



typedef Level4CatSelectCallback = void Function(int index);

class ScrollingAppBarLevel4Category extends StatelessWidget {
  const ScrollingAppBarLevel4Category({
    super.key, 
    required this.selectedIndex, 
    required this.level4List,
    required this.onTap,
  });
  final int selectedIndex;
  final Level4CatSelectCallback onTap;
  final List<Map<String, String>> level4List;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  const EdgeInsets.symmetric(
            vertical: 5, horizontal: kpadding10),
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // top back button
              Padding(
                padding: const EdgeInsets.only(left: 2, bottom: 20),
                child: CircularBackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  size: const Size(45, 45),
                ),
              ),
              // scrolling category
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: level4List.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      onTap(index);
                    },
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kDisabledBackground,
                              shape: BoxShape.circle,
                              border: selectedIndex == index ? Border.all(color: kSecondaryColor) : null,
                            ),
                            child: Image.asset(
                              level4List[index]
                                  ['cat_img']!,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Text(
                            level4List[index]['cat_name']!.toLowerCase(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: kPrimaryColor,
                                height: 1
                                // leadingDistribution: TextLeadingDistribution.proportional
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(
                    width: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
