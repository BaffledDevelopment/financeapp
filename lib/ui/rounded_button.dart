import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      height: size.width * 0.13,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          primary: Colors.cyan,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
