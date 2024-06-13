import 'package:flutter/material.dart';
import 'package:flutter_fire/module/intro/intro_state.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<IntroState>(
        create: (BuildContext context) => IntroState(context: context),
        child: Consumer<IntroState>(
          builder: (_, introState, __) {
            return Scaffold(
              body: Center(
                child: Image.asset("assets/images/flutter_fire_icon.png"),
              ),
            );
          },
        ),
      ),
    );
  }
}
