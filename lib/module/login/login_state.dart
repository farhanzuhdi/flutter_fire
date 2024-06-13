import 'package:flutter/material.dart';
import 'package:flutter_fire/core/ff_function.dart';

class LoginState with ChangeNotifier {
  BuildContext context;

  LoginState({required this.context});

  clickLogin() {
    fffunction.login(context);
  }
}
