import 'package:flutter/material.dart';
import 'package:flutter_fire/module/login/login_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginState>(
      create: (BuildContext context) => LoginState(context: context),
      child: Consumer<LoginState>(
        builder: (_, loginState, __) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login With Google Account",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/images/google_icon.png',
                        scale: 10.0,
                      ),
                      onPressed: () => loginState.clickLogin(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
