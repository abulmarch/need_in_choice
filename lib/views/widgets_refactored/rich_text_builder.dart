

import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';

class RichTextBuilder extends StatelessWidget {
  const RichTextBuilder({super.key, required this.text, this.fontSize = 9, this.overflow = TextOverflow.clip}): lastWord = false;
   const RichTextBuilder.firstWord({super.key, required this.text, this.fontSize = 9, this.overflow = TextOverflow.clip}) : lastWord = true;
  final String text;
  final bool lastWord;
  final double fontSize;
  final TextOverflow overflow;
  @override
  Widget build(BuildContext context) {
    if (!lastWord) {
      return RichText(//softWrap: true,
        text: TextSpan(
          text: text.replaceRange(text.length~/2, text.length, ''),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kFadedBlack),
          children: <TextSpan>[
            TextSpan(text: text.replaceRange(0,text.length~/2, '') ,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kPrimaryColor)),
          ],
        ),overflow: overflow,
        textAlign: TextAlign.center,
      );      
    } else {
      final List<String> listOfWords = text.split(' ');
      return listOfWords.length > 1 ?
      RichText(
        text: TextSpan(
          text: text.replaceRange(listOfWords.first.length, text.length, ''),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kFadedBlack),
          children: <TextSpan>[
            TextSpan(text: text.replaceRange(0, listOfWords.first.length, '') ,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kPrimaryColor)),
          ],
        ),overflow: overflow,
        textAlign: TextAlign.center,
      )
      : RichText(
        text: TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kFadedBlack),
          // children: <TextSpan>[
          //   TextSpan(text: text.replaceRange(0,text.length~/2, '') ,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kPrimaryColor)),
          // ],
        ),overflow: overflow,
        textAlign: TextAlign.center,
      );
    }
  }
}

class RichTextBuildFromMap extends StatelessWidget {
  const RichTextBuildFromMap({
    super.key, 
    required this.mapEntry,
    this.fontSize = 9,
    this.overflow = TextOverflow.clip
  });
  final MapEntry mapEntry;
  final double fontSize;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          text: '${mapEntry.key} '.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kFadedBlack),
          children: <TextSpan>[
            TextSpan(
              text: mapEntry.value is! Map 
              ? '${mapEntry.value}'.toUpperCase()
              : '${mapEntry.value['value']} ${mapEntry.value['unit']}'.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: fontSize,color: kPrimaryColor)
            ),
          ],
        ),overflow: overflow,
        textAlign: TextAlign.center,
      );
  }
}