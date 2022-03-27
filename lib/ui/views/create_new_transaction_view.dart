import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finances/models/category.dart';
import 'package:finances/viewmodels/create_new_transaction_model.dart';
import 'package:finances/ui/views/base_view.dart';

import '../../services/firebase_database_service.dart';

class CreateNewTransactionView extends StatelessWidget {
  final Category category;
  final int selectedCategory;

  CreateNewTransactionView(this.category, this.selectedCategory);

  @override
  Widget build(BuildContext context) {

    return BaseView<CreateNewTransactionModel>(
      onModelReady: (model) => model.init(selectedCategory, category.index),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: selectedCategory == 1
              ? const Text('Income')
              : const Text('Expense'),
          backgroundColor: const Color.fromARGB(255, 255, 241, 159),
        ),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(category.name),
                  leading: CircleAvatar(
                      child: Icon(
                    category.icon,
                    size: 20,
                  )),
                ),
                Container(height: 30.0),
                buildTextField(model!.memoController, 'Note:',
                    "Enter a note for your transaction", Icons.edit, false),
                Container(height: 20.0),
                buildTextField(
                    model.amountController,
                    'Amount:',
                    "Enter a the amount for the transaction",
                    Icons.attach_money,
                    true),
                Container(height: 20.0),
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
                SizedBox(
                  width: 20,
                  height: 50,
                  child: RaisedButton(
                    child: Text(model.getSelectedDate()),
                    onPressed: () async {
                      await model.selectDate(context);
                    },
                  ),
                ),
                Container(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RaisedButton(
                    child: const Text(
                      'ADD',
                      style: TextStyle(fontSize: 16),
                    ),
                    color: const Color.fromARGB(255, 255, 241, 159),
                    textColor: Colors.black,
                    onPressed: () async {

                      await model.addTransaction(context);

                    },
                  ),
                )
              ],
            ),
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
        border: const OutlineInputBorder(),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        labelText: text,
        suffixIcon: InkWell(
          onTap: () {
            controller.clear();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(
          color: Color(0xFFFF000000),
        ),
        helperText: helperText,
      ),
    );
  }
}
