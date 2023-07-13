import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: kPrimaryColor),
      ),
      content: content,
      actions: [
        TextButton(
          child: const Text(
            'Ok',
            style: TextStyle(color: kPrimaryColor),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}