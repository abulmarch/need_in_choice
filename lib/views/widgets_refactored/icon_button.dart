import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class IconWithButton extends StatelessWidget {
  final Function() onpressed;
  final String text;
  final IconData iconData;
  final double radius;
  final Size size;
  final FontWeight? fontWeight;
  final double? fontsize;
  final Color? background;
  const IconWithButton({
    super.key,
    required this.onpressed,
    required this.text,
    required this.iconData,
    required this.radius,
    required this.size,
    this.fontWeight = FontWeight.w600,
    this.fontsize = 20,
    this.background = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
        backgroundColor: MaterialStateProperty.all(background),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        elevation: MaterialStateProperty.all<double>(0),
        minimumSize: MaterialStateProperty.all<Size>(size),
        iconColor: MaterialStateProperty.all(kWhiteColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: fontWeight, fontSize: fontsize),
          ),
          kWidth5,
          Icon(
            iconData,
            size: 16,
          )
        ],
      ),
    );
  }
}

class IconWithButtonBottom extends StatelessWidget {
  final Function() onpressed;
  final String text;
  final IconData? iconData;
  final double radius;
  final Size size;
  final FontWeight? fontWeight;
  final double? fontsize;
  final Color? background;
  final Color? color;
  final String? imageAsset;

  const IconWithButtonBottom({
    super.key,
    required this.onpressed,
    required this.text,
    this.iconData,
    required this.radius,
    required this.size,
    this.fontWeight = FontWeight.w600,
    this.fontsize = 14,
    this.background = kPrimaryColor,
    this.color,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
        onTap: onpressed,
        child: Container(
          height: screenHeight * 0.065,
          width: screenWidth * .42,
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          padding: const EdgeInsets.only(
            left: 8,
            right: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: iconData != null
                    ? Icon(
                        iconData,
                        color: kPrimaryColor,
                      )
                    : imageAsset != null
                        ? Image.asset(
                            imageAsset!,
                          )
                        : null,
              ),
              //kWidth20,
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: fontWeight, fontSize: fontsize),
              ),
            ],
          ),
        ));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return InkWell(
//       onTap: ontap,
//       child: Container(
//         height: screenHeight * 0.085,
//         width: screenWidth * .8,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 8,
//         ),
//         decoration: BoxDecoration(
//           color: button,
//           borderRadius: const BorderRadius.all(Radius.circular(100)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Spacer(),
//             RichText(
//               text: TextSpan(
//                   text: boldText,
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleLarge!
//                       .copyWith(color: textcolor, fontSize: 20),
//                   children: [
//                     TextSpan(
//                       text: lightText,
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                           fontWeight: FontWeight.w300,
//                           color: textcolor,
//                           fontSize: 20),
//                     )
//                   ]),
//             ),
//             const Spacer(),
//             Container(
//               height: 50,
//               width: 50,
//               decoration: BoxDecoration(
//                 color: circle,
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.arrow_forward_ios_sharp,
//                   color: arrow,
//                 ),
//               ),
//             ),
//             // kWidth10,
//           ],
//         ),
//       ),
//     );
//   }
// }
