import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:planet_plus/providers/planet_provider.dart';
import 'package:planet_plus/providers/voice_player_provider.dart';
import 'package:planet_plus/services/LocalizationString.dart';
import 'package:planet_plus/services/update_checker.dart';

import 'config/app_routes.dart';

void main() async {
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
    return ScreenUtilInit(
      designSize: const Size(360, 890),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Solar System Explorer',
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          initialBinding: AppBindings(), // Initialize controllers here
          home: UpdateGatekeeper(),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          locale: const Locale('bn', 'BD'),
          fallbackLocale: const Locale('en', 'US'),
          translations: LocalizationString(),
          builder: (context, child) => child!,
        );
      },
    );
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // LazyPut would initialize when first used
    Get.lazyPut(() => PlanetController(), fenix: true);
    Get.lazyPut(() => VoicePlayerController(), fenix: true);

  }
}