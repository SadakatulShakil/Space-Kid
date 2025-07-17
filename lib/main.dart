import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planet_plus/providers/planet_provider.dart';
import 'package:planet_plus/providers/voice_player_provider.dart';
import 'package:planet_plus/services/update_checker.dart';
import 'package:provider/provider.dart';

import 'config/app_routes.dart';
import 'config/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlanetProvider()),
        ChangeNotifierProvider(create: (_) => VoicePlayerController()),
      ],
      child: MaterialApp(
        title: 'Solar System Explorer',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: UpdateGatekeeper(), // ✅ Add this as your first screen
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}