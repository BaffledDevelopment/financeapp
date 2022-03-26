import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finances/locator.dart';
import 'package:finances/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:finances/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../enum_viewstate.dart';
import '../ui/views/home_view.dart';
import 'base_model.dart';

class RegisterViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future signUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    setState(ViewState.Busy);

    var result = await _authenticationService.signUpWithEmail(
        email: email, password: password, name: name);

    setState(ViewState.Idle);

    if (result is bool) {
      // TODO: navigation inside model IS ABSOLUTE HARAM

      if (result) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeView()),
            (Route<dynamic> route) => false);

        final user = FirebaseAuth.instance.currentUser!;

        FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
                  'uid': user.uid,
                  'name': name,
                  'email': email,
                  'hashedPassword': password,
                })
                .then((value) => print("User added!"))
                .catchError((e) => print("Failed to add user"))
            as CollectionReference<Object?>;
      } else {
        Fluttertoast.showToast(
            msg: "General sign up failure. Please try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }
  }
}
