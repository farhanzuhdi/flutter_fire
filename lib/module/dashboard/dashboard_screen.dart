import 'package:flutter/material.dart';
import 'package:flutter_fire/module/dashboard/dashboard_state.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardState>(
      create: (BuildContext context) => DashboardState(context: context),
      child: Consumer<DashboardState>(
        builder: (_, dashboardState, __) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Halo, ${dashboardState.name == '' || dashboardState.name == null ? 'Name' : dashboardState.name}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 95,
                  width: 95,
                  decoration: BoxDecoration(
                    color: dashboardState.photoURL == "" ||
                            dashboardState.photoURL == null
                        ? Colors.grey.shade300
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: dashboardState.photoURL == "" ||
                              dashboardState.photoURL == null
                          ? Image.asset(
                              "assets/images/google_icon.png",
                              scale: 10.0,
                            ).image
                          : NetworkImage(dashboardState.photoURL.toString()),
                    ),
                  ),
                ),
                Text(
                  dashboardState.email == "" || dashboardState.email == null
                      ? ''
                      : dashboardState.email.toString(),
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    child: const Text('Logout', style: TextStyle(fontSize: 18)),
                    onPressed: () => dashboardState.logout(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
