import 'package:flutter/material.dart';
import 'package:flutter_fire/core/ff_function.dart';
import 'package:flutter_fire/module/login/login_screen.dart';

class IntroState with ChangeNotifier {
  BuildContext context;
  ValueNotifier userCredential = ValueNotifier('');

  IntroState({required this.context}) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      init();
    });
  }

  init() async {
    if (await fffunction.getSharedPreferences(
            type: "getString", key: "email") !=
        "") {
      try {
        if (!context.mounted) return;
        fffunction.login(context);
      } catch (e) {
        if (!context.mounted) return;
        fffunction.showMessageSnackBar(context, e.toString());
      }
    } else {
      if (!context.mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }
}
