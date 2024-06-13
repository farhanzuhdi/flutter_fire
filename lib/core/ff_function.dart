import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/module/dashboard/dashboard_screen.dart';
import 'package:flutter_fire/module/login/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_loading_dialog/simple_loading_dialog.dart';

class FFFunction {
  ValueNotifier userCredential = ValueNotifier('');
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences? sharedPreferences;

  Future<String> getSharedPreferences(
      {required String type, required String key, String? value}) async {
    sharedPreferences = await _prefs;
    String result = "";
    if (type == "setString") {
      sharedPreferences!.setString(key, value.toString());
      return result;
    } else if (type == "getString") {
      result = sharedPreferences?.getString(key) == null
          ? ""
          : sharedPreferences!.getString(key).toString();
      return result;
    } else {
      return result;
    }
  }

  void showMessageSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 3000),
      ),
    );
  }

  void login(BuildContext context) async {
    sharedPreferences = await _prefs;
    try {
      if (!context.mounted) return;
      await showSimpleLoadingDialog<void>(
          context: context, future: _signInWithGoogle);
      if (sharedPreferences!.getString("email") != null ||
          sharedPreferences!.getString("email") != "") {
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      } else {
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } catch (e) {
      if (!context.mounted) return;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      if (!context.mounted) return;
      showMessageSnackBar(context, e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential.value =
          await FirebaseAuth.instance.signInWithCredential(credential);
      sharedPreferences!
          .setString("photoURL", userCredential.value.user.photoURL);
      sharedPreferences!
          .setString("name", userCredential.value.user.displayName);
      sharedPreferences!.setString("email", userCredential.value.user.email);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  signOutFromGoogle(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      sharedPreferences?.clear();
      if (!context.mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      return true;
    } on Exception catch (e) {
      if (!context.mounted) return;
      return showMessageSnackBar(context, e.toString());
    }
  }
}

var fffunction = FFFunction();
