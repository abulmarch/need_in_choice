import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';

class UpdateAdressBottomSheet extends StatelessWidget {
  const UpdateAdressBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
          color: kWhiteColor, borderRadius: BorderRadius.circular(100)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Update Location',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: kBlackColor, fontSize: 35),
            ),
            kHeight10,
            Text(
              'Saved Adress',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            kHeight10,
            Text(
              ' Calletic Technologies Pvt Ltd \n4th Floor, Nila, Technopark Campus, \nTechnopark Campus, Kazhakkoottam, \nThiruvananthapuram, Kerala 695581',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            kHeight20,
            Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Auto Fetch',
                      style: Theme.of(context).textTheme.labelMedium,
                      children: [
                        TextSpan(
                          text: ' Location',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: kPrimaryColor),
                        )
                      ]),
                ),
                kWidth5,
                const Icon(Icons.refresh),
              ],
            ),
            kHeight10,
            Container(
              height: 217,
              width: 359,
              decoration: BoxDecoration(
                  color: const Color(0XFFF3F3F3),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                      ' Calletic Technologies Pvt Ltd \n4th Floor, Nila, Technopark Campus, \nTechnopark Campus, Kazhakkoottam, \nThiruvananthapuram, Kerala 695581',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16, color: const Color(0XFF525151)))),
            ),
            kHeight10,
            ElevatedButton(
              style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0XFF303030)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(const Size(321, 61)),
        ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: RichText(
                text: TextSpan(
                  text: 'Save', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kWhiteColor, fontSize: 23),
                  children: [
                    TextSpan(
                  text: 'Location', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kPrimaryColor, fontSize: 23),),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
