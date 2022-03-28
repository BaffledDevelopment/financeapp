import 'package:flutter/material.dart';

class ChangerOfCurrencyType extends StatelessWidget {
  final selectedItem;
  final Function changedSelectedItem;

  const ChangerOfCurrencyType(this.selectedItem, this.changedSelectedItem);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedItem,
        items: const [
          DropdownMenuItem(
            child: Text("USD"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("RUB"),
            value: 2,
          ),
          DropdownMenuItem(
            child: Text("POPUG"),
            value: 3,
          ),
        ],
        onChanged: (value) {
          changedSelectedItem(value);

        });
  }
}
