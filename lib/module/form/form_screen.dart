import 'package:flutter/material.dart';
import 'package:flutter_fire/module/form/form_state.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FormmState>(
      create: (BuildContext context) => FormmState(context: context),
      child: Consumer<FormmState>(
        builder: (_, formmState, __) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) => formmState.back(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Edit Data"),
                leading: InkWell(
                    onTap: () => formmState.back(),
                    child: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: formmState.name,
                      decoration: InputDecoration(
                        hintText: "Name",
                        isDense: true,
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 95,
                      width: 95,
                      decoration: BoxDecoration(
                        color: formmState.photoURL == "" ||
                                formmState.photoURL == null
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: formmState.photoURL == "" ||
                                  formmState.photoURL == null
                              ? Image.asset(
                                  "assets/images/google_icon.png",
                                  scale: 10.0,
                                ).image
                              : NetworkImage(formmState.photoURL.toString()),
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: const Text('Change Photo Profile',
                            style: TextStyle(
                                fontSize: 18, color: Colors.blueAccent)),
                        onPressed: () => formmState.pickImage(),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: const Text('Save',
                            style: TextStyle(
                                fontSize: 18, color: Colors.blueAccent)),
                        onPressed: () => formmState.updateUser(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
