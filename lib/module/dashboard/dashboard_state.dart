import 'package:flutter/material.dart';
import 'package:flutter_fire/core/ff_function.dart';
import 'package:flutter_fire/module/form/form_screen.dart';

class DashboardState with ChangeNotifier {
  BuildContext context;
  String? photoURL, name, email;

  DashboardState({required this.context}) {
    getData();
  }

  getData() async {
    photoURL = await fffunction.getSharedPreferences(
        type: "getString", key: "photoURL");
    name =
        await fffunction.getSharedPreferences(type: "getString", key: "name");
    email =
        await fffunction.getSharedPreferences(type: "getString", key: "email");
    notifyListeners();
  }

  logout() {
    fffunction.signOutFromGoogle(context);
  }

  edit() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const FormScreen()));
  }
}
