import 'package:flutter/material.dart';
import 'package:my_project/utils/appvalidator.dart';
import 'package:my_project/widgets/category_dropdown.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  var type = "credit";
  var category = "Others";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var isLoader = true;
  var appValidator = AppValidator();
  Future<void> _submitform() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      // var data = {
      //   "email": _emailController.text,
      //   "password": _passwordController.text,
      // };

      // await authServices.login(data, context);
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => Dashboard()));
      setState(() {
        isLoader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            CategoryDropDown(
              cattype: category,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    category = value;
                  });
                }
              },
            ),
            DropdownButtonFormField(
                value: 'credit',
                items: [
                  DropdownMenuItem(child: Text('Credit'), value: 'credit'),
                  DropdownMenuItem(child: Text('Debit'), value: 'debit'),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      type = value;
                    });
                  }
                }),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if(isLoader == false){
                    _submitform();
                  }
                  // _submitform();
                },
                child:
                isLoader ? Center(child: CircularProgressIndicator()):
                 Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
