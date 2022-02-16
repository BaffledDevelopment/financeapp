import 'package:flutter/material.dart';
import 'package:finances/models/category.dart';
import 'package:finances/viewmodels/create_new_transaction_model.dart';
import 'package:finances/ui/views/base_view.dart';

class CreateNewTransactionView extends StatefulWidget {

  final Category category;
  final int selectedCategory;

  CreateNewTransactionView(this.category, this.selectedCategory);

  @override
  _CreateNewTransactionViewState createState() =>
      _CreateNewTransactionViewState();


}

class _CreateNewTransactionViewState extends State<CreateNewTransactionView>{
  String _value = '';

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());
    if (picked != null) setState(() => _value = picked.toString());

    print(picked?.day);
    print(picked?.month);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController memoController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    return BaseView<CreateNewTransactionModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title:
          widget.selectedCategory == 1 ? Text('Income') : Text('Expense'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                buildTextField(memoController, 'Note:',
                    "Enter a note for your transaction", Icons.edit, false),
                Container(height: 20.0),
                buildTextField(
                    amountController,
                    'Amount:',
                    "Enter a the amount for the transaction",
                    Icons.attach_money,
                    true),
                RaisedButton(onPressed: () async {
                  await _selectDate();
                })
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
          color: Color(0xffff000000),
        ),
        helperText: helperText,
      ),
    );
  }

}