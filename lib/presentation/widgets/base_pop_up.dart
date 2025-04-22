import 'package:flutter/material.dart';

class BasePopUpDialog extends StatelessWidget {
  final String question;
  final String yesText;
  final String noText;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  const BasePopUpDialog({
    super.key,
    required this.question,
    required this.yesText,
    required this.noText,
    required this.onYesPressed,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Konfirmasi'),
      content: Text(question, style: Theme.of(context).textTheme.labelMedium),
      actions: <Widget>[
        TextButton(
          child: Text(
            noText,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            onNoPressed();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            yesText,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            onYesPressed();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
