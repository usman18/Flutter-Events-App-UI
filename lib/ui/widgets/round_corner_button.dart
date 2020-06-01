import 'package:flutter/material.dart';



typedef OnTap = void Function();

class RoundCornerButton extends StatelessWidget {
  final String text;
  final Color buttonColor;

  final OnTap onTap;

  const RoundCornerButton({Key key, this.text, this.buttonColor, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      child: Text(text ?? "",),
      color: buttonColor,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(36),
          right: Radius.circular(36),
        ),
      ),
    );
  }
}
