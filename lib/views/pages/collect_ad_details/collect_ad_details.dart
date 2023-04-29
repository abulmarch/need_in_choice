import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';

import '../../../utils/category_and_subcategory_info.dart';
import '../../../utils/constants.dart';
import '../../widgets_refactored/circular_back_button.dart';


class CollectAdDetails extends StatelessWidget {
  const CollectAdDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      // scrolling sub-cattegory
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2,bottom: 20),
                    child: CircularBackButton(
                      onPressed: (){Navigator.of(context).pop();},
                      size: const Size(45, 45),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: building4saleCommercial.length,
                      itemBuilder: (context, index) => SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 60,width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kDisabledBackground,
                                shape: BoxShape.circle,
                                border: building4saleCommercial[index]['cat_name']! == 'restaurant' ? Border.all(color: kSecondaryColor) : null,
                              ),
                              child: Image.asset(building4saleCommercial[index]['cat_img']!,height: 50,width: 50,),
                            ),
                            Text(
                              building4saleCommercial[index]['cat_name']!.toLowerCase(),
                              style: const TextStyle(
                                fontSize: 10,
                                color: kPrimaryColor,height: 1
                                // leadingDistribution: TextLeadingDistribution.proportional
                                
                              ),
                            )
                          ],
                        ),
                      ), 
                      separatorBuilder: (context, index) => const SizedBox(width: 1,), 
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), 
      ),

      body: LayoutBuilder(
        builder: (ctx, cons) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: cons.maxHeight,
                  width: cons.maxWidth,
                  child: Center(
                    child: Listener(
                      onPointerMove: (event) {
                        print(event.buttons.ceilToDouble());
                      },
                      child: Text('view less data')
                    )
                  ),
                ),
                Container(
                  height: cons.maxHeight,
                  width: cons.maxWidth,
                  child: Center(child: Text('view more data')),
                ),
              ],
            ),
          );
        },
      ),
      //  bottom continue button
      bottomNavigationBar: const SizedBox(
        width: double.infinity,
        height: 70,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          child: ButtonWithRightSideIcon(
            onPressed: null//(){},//
          ),
        ),
      ),
    );
  }
}

class ButtonWithRightSideIcon extends StatelessWidget {
  const ButtonWithRightSideIcon({
    super.key, 
    required this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ElevatedButton.icon(
        icon: RotatedBox(
          quarterTurns: 3,
          child: Container(width: 45,height: 45,
            decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: const RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: kPrimaryColor, 
                size: kpadding15,
              )
            ),
          )
          // Icon(Icons.expand_circle_down,color: kWhiteColor,size: 50,)
        ),
        
        label: const Center(
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 25,
              color: kWhiteColor
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          // disabledForegroundColor: kPrimaryColor.withOpacity(0.5),
          disabledBackgroundColor: kPrimaryColor.withOpacity(0.2),

        ),
        onPressed: onPressed,
      ),
    );
  }
}