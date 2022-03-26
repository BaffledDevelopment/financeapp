import 'package:finances/locator.dart';
import 'package:finances/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:finances/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../enum_viewstate.dart';
import '../ui/views/home_view.dart';
import 'base_model.dart';

class AuthModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();

  Future logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    setState(ViewState.Busy);

    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    setState(ViewState.Idle);

    if (result is bool) {

      if (result) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeView()),
                (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(
            msg: "General login up failure. Please try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }
  }
}
