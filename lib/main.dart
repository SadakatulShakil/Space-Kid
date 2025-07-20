import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:planet_plus/providers/planet_provider.dart';
import 'package:planet_plus/providers/voice_player_provider.dart';
import 'package:planet_plus/services/LocalizationString.dart';
import 'package:planet_plus/services/update_checker.dart';
import 'package:provider/provider.dart';

import 'config/app_routes.dart';
import 'config/theme.dart';

void main() async{
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
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: 'Solar System Explorer',
            theme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            home: UpdateGatekeeper(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            locale: const Locale('bn', 'BD'),
            fallbackLocale: const Locale('en', 'US'), // ✅ Critical for language switching
            translations: LocalizationString(),
            builder: (context, child) => child!, // ✅ Clean builder
          );
        },
      ),
    );
  }
}
