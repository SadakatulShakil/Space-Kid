import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

import '../config/app_routes.dart';

class UpdateGatekeeper extends StatefulWidget {
  const UpdateGatekeeper({super.key});

  @override
  State<UpdateGatekeeper> createState() => _UpdateGatekeeperState();
}

class _UpdateGatekeeperState extends State<UpdateGatekeeper> {
  bool _checkingUpdate = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  Future<void> _checkForUpdate() async {
    try {
      final updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable &&
          updateInfo.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _checkingUpdate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingUpdate) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Update check failed:\n$_error",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    // ✅ If no update or already updated, go to your app’s home screen
    return Navigator(
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
