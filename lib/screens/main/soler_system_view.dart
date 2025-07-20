import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:planet_plus/screens/main/widgets/enhanced_star.dart';
import 'package:provider/provider.dart';
import '../../models/planet_model.dart';
import '../../providers/planet_provider.dart';

class SolarSystemView extends StatefulWidget {
  const SolarSystemView({Key? key}) : super(key: key);

  @override
  _SolarSystemViewState createState() => _SolarSystemViewState();
}

class _SolarSystemViewState extends State<SolarSystemView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Map<String, double> initialAngles = {
    'mercury': 0.0,
    'venus': pi / 4,
    'earth': pi / 8,
    'mars': 3 * pi / 4,
    'jupiter': pi,
    'saturn': 5 * pi / 3,
    'uranus': 3 * pi / 5,
    'neptune': 7 * pi / 4,
  };

  final Map<String, int> planetNumbers = {
    'mercury': 1,
    'venus': 2,
    'earth': 3,
    'mars': 4,
    'jupiter': 5,
    'saturn': 6,
    'uranus': 7,
    'neptune': 8,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30), // Slower animation for better visibility
    )..repeat();
    _controller.addListener(() {
      if (mounted) setState(() {}); // Ensure widget is still mounted
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, double> getOrbitRadii(Size size) {
    final screenRadius = min(size.width, size.height) / 2 - 50.w;
    final radiiStep = screenRadius / 6.1;
    return {
      'mercury': radiiStep * 1,
      'venus': radiiStep * 2,
      'earth': radiiStep * 3,
      'mars': radiiStep * 4,
      'jupiter': radiiStep * 5,
      'saturn': radiiStep * 6,
      'uranus': radiiStep * 7,
      'neptune': radiiStep * 8,
    };
  }

  double getPlanetSize(String id) {
    switch (id) {
      case 'jupiter': return 50.w;
      case 'saturn': return 75.w;
      case 'uranus': return 50.w;
      case 'neptune': return 45.w;
      case 'earth': return 40.w;
      case 'venus': return 35.w;
      case 'mars': return 35.w;
      case 'mercury': return 30.w;
      default: return 30.w;
    }
  }

  void _handlePlanetTap(BuildContext context, CelestialBody planet) {
    context.read<PlanetProvider>().selectPlanet(planet.id);
    Navigator.pushNamed(context, '/planet-detail');
  }

  void _handleSunTap(BuildContext context, String id) {
    context.read<PlanetProvider>().selectPlanet(id);
    Navigator.pushNamed(context, '/planet-detail');
  }

  void _changeLanguage() {
    final currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'en') {
      Get.updateLocale(const Locale('bn', 'BD'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
    setState(() {}); // Force rebuild to update translations
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _changeLanguage,
        child: Icon(Icons.language, size: 24.w),
        mini: true,
        backgroundColor: Colors.blue.withOpacity(0.7),
      ),
      body: Consumer<PlanetProvider>(
        builder: (context, provider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final size = Size(constraints.maxWidth, constraints.maxHeight);
              final orbitRadii = getOrbitRadii(size);
              final centerX = size.width / 2;
              final centerY = size.height / 2;

              final orderedPlanets = provider.planets
                  .where((p) => p.id != 'sun')
                  .toList()
                ..sort((a, b) => planetNumbers[a.id]!.compareTo(planetNumbers[b.id]!));

              return Stack(
                children: [
                  StarField(),
                  Positioned.fill(
                    child: InteractiveViewer(
                      boundaryMargin: EdgeInsets.all(double.infinity),
                      minScale: 0.2,
                      maxScale: 5.5,
                      child: Stack(
                        children: [
                          // Sun
                          Positioned(
                            left: centerX - 15.w,
                            top: centerY - 15.w,
                            child: GestureDetector(
                              onTap: () => _handleSunTap(context, 'sun'),
                              child: SizedBox(
                                width: 30.w,
                                height: 30.w,
                                child: Image.asset("assets/images/sun.png"),
                              ),
                            ),
                          ),

                          // Orbits
                          ...orbitRadii.entries.map((entry) {
                            final radius = entry.value;
                            return Positioned(
                              left: centerX - radius,
                              top: centerY - radius,
                              child: Container(
                                width: radius * 2,
                                height: radius * 2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.6),
                                    width: 1.w,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          // Planets
                          ...orderedPlanets.map((planet) {
                            final radius = orbitRadii[planet.id];
                            final planetSize = getPlanetSize(planet.id);
                            final planetNumber = planetNumbers[planet.id]!;

                            if (radius == null) return const SizedBox.shrink();

                            final angle = _controller.value * 2 * pi + initialAngles[planet.id]!;
                            final offsetX = centerX + radius * cos(angle);
                            final offsetY = centerY + radius * sin(angle);

                            return Positioned(
                              left: offsetX - (planetSize / 2),
                              top: offsetY - (planetSize / 2),
                              child: GestureDetector(
                                onTap: () => _handlePlanetTap(context, planet),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: planetSize,
                                      height: planet.id == 'saturn' ? planetSize * 0.5 : planetSize,
                                      decoration: BoxDecoration(
                                        shape: planet.id == 'saturn' ? BoxShape.rectangle : BoxShape.circle,
                                      ),
                                      child: Hero(
                                        tag: planet.id,
                                        child: Image.asset(
                                          planet.imageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '$planetNumber',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),

                  // Legend
                  Positioned(
                    top: 40.h,
                    left: 10.w,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: orderedPlanets.map((planet) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Text(
                              '${planetNumbers[planet.id]} = ${planet.name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}