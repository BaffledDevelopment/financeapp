import 'package:finances/services/auth_service.dart';
import 'package:finances/services/icon_service.dart';
import 'package:finances/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:finances/enum_viewstate.dart';
import 'package:finances/locator.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
}