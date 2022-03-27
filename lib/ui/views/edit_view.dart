import 'package:finances/viewmodels/edit_model.dart';
import 'package:flutter/material.dart';
import 'package:finances/viewmodels/edit_model.dart';

import '../../models/transaction.dart';
import 'base_view.dart';

class EditView extends StatelessWidget {
  final ExpenseTransaction transaction;

  EditView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditModel>(
      onModelReady: (model) => model.init(transaction),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
            backgroundColor: Colors.cyan
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text(model!.category.name),
                leading: CircleAvatar(
                    child: Icon(
                  model.category.icon,
                  size: 20,
                )),
              ),
              Container(height: 15),
              buildTextField(model.memoController, 'Note:',
                  "Enter a note for your transaction", Icons.edit, false),
              Container(height: 15),
              buildTextField(
                  model.amountController,
                  'Amount:',
                  "Enter a the amount for the transaction",
                  Icons.attach_money,
                  true),
              Container(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SELECT DATE:',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Container(
                width: 20,
                height: 50,
                child: RaisedButton(
                  child: Text(model.getSelectedDate()),
                  onPressed: () async {
                    await model.selectDate(context);
                  },
                ),
              ),
              Container(height: 15),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(
                        color: Colors.pink,
                        width: 1.0,
                      ),
                    ),
                  )),
                  child: Text("EDIT"),
                  onPressed: () async {
                    await model.editTransaction(context, transaction);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextField(TextEditingController controller, String text,
      String helperText, IconData icon, isNumeric) {
    return TextFormField(
      cursorColor: Colors.black,
      maxLength: isNumeric ? 10 : 40,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
