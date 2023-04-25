

import 'package:flutter/material.dart';
import 'package:need_in_choice/utils/colors.dart';

class RichTextBuilder extends StatelessWidget {
  const RichTextBuilder({super.key, required this.text}): lastWord = false;
   const RichTextBuilder.lastWord({super.key, required this.text}) : lastWord = true;
  final String text;
  final bool lastWord;
  @override
  Widget build(BuildContext context) {
    if (!lastWord) {
      return RichText(
        text: TextSpan(
          text: text.replaceRange(text.length~/2, text.length, ''),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: 9,color: kFadedBlack),
          children: <TextSpan>[
            TextSpan(text: text.replaceRange(0,text.length~/2, '') ,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: 9,color: kPrimaryColor)),
          ],
        ),
        textAlign: TextAlign.center,
      );      
    } else {
      final List<String> listOfWords = text.split(' ');
      return listOfWords.length > 1 ?
      RichText(
        text: TextSpan(
          text: text.replaceRange(listOfWords.first.length, text.length, ''),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: 9,color: kFadedBlack),
          children: <TextSpan>[
            TextSpan(text: text.replaceRange(0, listOfWords.first.length, '') ,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: 9,color: kPrimaryColor)),
          ],
        ),
        textAlign: TextAlign.center,
      )
      : RichText(
        text: TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: 9,color: kFadedBlack),
          // children: <TextSpan>[
          //   TextSpan(text: text.replaceRange(0,text.length~/2, '') ,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500,fontSize: 9,color: kPrimaryColor)),
          // ],
        ),
        textAlign: TextAlign.center,
      );
    }
  }
}