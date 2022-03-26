import 'package:finances/ui/views/auth_view.dart';
import 'package:finances/ui/views/base_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finances/viewmodels/register_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:finances/locator.dart';

import '../rounded_field.dart';
import '../rounded_button.dart';
import '../rounded_input_field.dart';

class SignupPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      // onModelReady: (model) => model.init(),
      builder: (context, model, widget) => Scaffold(
        // backgroundColor: Color(0xFFF0F0F0),
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context!);
            },
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Start saving money!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Create an account to get all features',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: MediaQuery.of(context!).size.width * 0.03,
                          color: Color(0xFFA1A1A1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RoundedInputField(
                        hintText: "Name",
                        controller: nameController,
                        onChanged: (name) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RoundedInputField(
                        hintText: "Email",
                        controller: emailController,
                        onChanged: (email) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RoundedPasswordField(
                        controller: passwordController,
                        onChanged: (password) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RoundedPasswordField(
                        controller: passwordConfirmController,
                        onChanged: (email) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RoundedButton(  text: "Sign Up",
                        press: () async {
                          if (passwordController.text ==
                              passwordConfirmController.text) {
                            try {
                              await model?.signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  context: context);
                            } on FirebaseAuthException catch (e) {
                              print(e);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Something went wrong",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM);
                          }
                        },
                      ),),

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
