import 'package:finances/viewmodels/home_model.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final HomeModel? model;
  final String? title;
  const MyAppBar({Key? key, this.model, this.title})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // model?.titleClicked();
        Navigator.of(context).pushNamed("select");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            model!.isCollapsed
                ? const Icon(
              Icons.arrow_drop_down,
            )
                : const Icon(
              Icons.arrow_drop_up,
            ),
          ],
        ),
      ),
    );
  }
}