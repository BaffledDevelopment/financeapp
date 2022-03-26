import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../viewmodels/auth_model.dart';
import 'base_view.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthModel>(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.cyan,
              ),
              body: Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/wallet.png',
                          width: 150,
                          height: 150,
                        ),
                        Container(
                          height: 50.0,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.orangeAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.orangeAccent)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown)),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                print('Forgot Password!');
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              if (emailController.text.isNotEmpty ||
                                  passwordController.text.isNotEmpty) {
                                try {
                                  await model?.logIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      context:
                                          context!); // passing context into model is haram
                                  //  REFACTOR THIS
                                } on FirebaseAuthException catch (e) {
                                  print(e);
                                }
                                // Navigator.pushNamed(context!, "home");
                              }
                            },
                            color: Colors.cyan,
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '''Don't have an account? ''',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16.0,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                print('Sign Up');
                                Navigator.of(context!)
                                    .pushNamed("registration");
                              },
                              child: const Text('Register Now'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
