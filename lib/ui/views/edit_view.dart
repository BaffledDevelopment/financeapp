import 'package:finances/database/databaseimpl.dart';
import 'package:finances/viewmodels/edit_model.dart';
import 'package:flutter/material.dart';
import 'package:finances/database/databaseimpl.dart';
import 'package:finances/viewmodels/edit_model.dart';


import 'base_view.dart';

class EditView extends StatelessWidget {
  final Transaction transaction;
  EditView(this.transaction);

  @override
  Widget build(BuildContext context) {
    return BaseView<EditModel>(
      onModelReady: (model) => model.init(transaction),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Edit'),
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

              buildTextField(model.memoController, 'Memo:',
                  "Enter a memo for your transaction", Icons.edit, false),

              buildTextField(
                  model.amountController,
                  'Amount:',
                  "Enter a the amount for the transaction",
                  Icons.attach_money,
                  true),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SELECT DATE:',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                ),
              ),
              Divider(
                thickness: 2,
              ),
              Divider(
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

              Align(
                alignment: Alignment.centerLeft,
                child: RaisedButton(
                  child: Text(
                    'EDIT',
                    style: TextStyle(fontSize: 16),
                  ),
                  color: Color.fromARGB(255, 255, 241, 159),
                  textColor: Colors.black,
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