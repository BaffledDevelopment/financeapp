import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  final String hintText;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.cyan),

          // color: Colors.cyanAccent,
          borderRadius: BorderRadius.circular(25)),
      child: TextField(
        controller: controller,
        obscureText: false,
        onChanged: onChanged,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          hintText: hintText,
          focusColor: Theme.of(context).colorScheme.primary,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
