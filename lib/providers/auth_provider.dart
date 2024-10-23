import 'dart:io';

import 'package:adopt_app/models/user.dart';
import 'package:adopt_app/services/auth_services.dart';
import 'package:adopt_app/services/client.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String token = "";
  late User user;

  void signup({required User user}) async {
    var token = await AuthServices().signup(user: user);
    this.user = User.fromJson(Jwt.parseJwt(token));
    _setToken(token);
    print(token);
    notifyListeners();
  }

  Future<bool> signin({required User user}) async {
    try {
      token = await AuthServices().signin(user: user);
      this.user = User.fromJson(Jwt.parseJwt(token));
      _setToken(token);
      print(token);
      notifyListeners();
      return true;
    } on Exception {
      return false;
    }
  }

  bool isAuth() {
    //  _getToken();
    if (token.isNotEmpty && !Jwt.isExpired(token)) {
      user = User.fromJson(Jwt.parseJwt(token));
      Client.dio.options.headers = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      return true;
    }
    // logout();
    return false;
  }

  Future<void> initialization() async {
    await _getToken();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    token = "";
    notifyListeners();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? "";
    notifyListeners();
  }

  void _setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
