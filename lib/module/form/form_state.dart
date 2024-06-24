import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fire/core/ff_function.dart';
import 'package:flutter_fire/module/dashboard/dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';

class FormmState with ChangeNotifier {
  BuildContext context;
  TextEditingController name = TextEditingController();
  File? imageFile;
  final picker = ImagePicker();
  String? photoURL;

  FormmState({required this.context}) {
    getData();
  }

  getData() async {
    photoURL = await fffunction.getSharedPreferences(
        type: "getString", key: "photoURL");
    name.text =
        await fffunction.getSharedPreferences(type: "getString", key: "name");
    notifyListeners();
  }

  back() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()));
  }

  updateUser() async {
    fffunction.updateUser(
        context: !context.mounted ? context : context,
        id: await fffunction.getSharedPreferences(type: "getString", key: "id"),
        name: name.text);
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    imageFile = File(pickedFile!.path);

    fffunction.uploadImageToFirebase(
        !context.mounted ? context : context,
        imageFile!,
        await fffunction.getSharedPreferences(type: "getString", key: "id"));

    getData();
  }
}
