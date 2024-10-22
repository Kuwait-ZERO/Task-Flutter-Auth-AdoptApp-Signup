import 'package:adopt_app/models/user.dart';
import 'package:adopt_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String token = "";
  late User user;

  void signup({required User user}) async {
    var token = await AuthServices().signup(user: user);
    print(token);
  }
}
