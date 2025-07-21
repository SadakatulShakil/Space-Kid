import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:planet_plus/screens/main/widgets/enhanced_star.dart';
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
  final PlanetController planetController = Get.put(PlanetController());

  final Map<String, double> initialAngles = {
    'mercury': 0.0,
    'venus': 1.5 * pi / 4,
    'earth': 3 * pi / 4,
    'mars': pi,
    'jupiter': 4 * pi / 3,
    'saturn': 6 * pi / 3.5,
    'uranus': 7.5 * pi / 4,
    'neptune': 8.5 * pi / 4,
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
      duration: const Duration(seconds: 30),
    )..addListener(() {
      if (mounted) setState(() {});
    })..repeat();
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
      case 'jupiter': return 45.w;
      case 'saturn': return 68.w;
      case 'uranus': return 50.w;
      case 'neptune': return 50.w;
      case 'earth': return 45.w;
      case 'venus': return 32.w;
      case 'mars': return 38.w;
      case 'mercury': return 25.w;
      default: return 30.w;
    }
  }

  void _handlePlanetTap(CelestialBody planet) {
    planetController.selectPlanet(planet.id);
    Get.toNamed('/planet-detail');
  }

  void _handleSunTap(String id) {
    print('Sun printed');
    planetController.selectPlanet(id);
    Get.toNamed('/planet-detail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withAlpha(200),
        onPressed: () {
          planetController.selectedLanguage = [
            !planetController.selectedLanguage[0],
            !planetController.selectedLanguage[1]
          ];
          planetController.changeLanguage(
              planetController.selectedLanguage[1] ? 1 : 0
          );
        },
        child: Obx(() {
          return Text(
            planetController.selectedLanguage[1] ? '🇺🇸' : '🇧🇩',
            style: const TextStyle(fontSize: 25),
          );
        }),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final orbitRadii = getOrbitRadii(size);
          final centerX = size.width / 2;
          final centerY = size.height / 2;

          final orderedPlanets = planetController.planets
              .where((p) => p.id != 'sun')
              .toList()
            ..sort((a, b) => planetNumbers[a.id]!.compareTo(planetNumbers[b.id]!));

          return Stack(
            children: [
              StarField(),
              Positioned.fill(
                child: InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(double.infinity),
                  minScale: 0.05,
                  maxScale: 6.0,
                  child: Stack(
                    children: [
                      // Sun
                      Positioned(
                        left: centerX - 17.w,
                        top: centerY - 17.w,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(0.5),
                                blurRadius: 100.w,
                                spreadRadius: 50.w,
                              ),
                            ],
                          ),
                          width: 34.w,
                          height: 34.w,
                          child: Image.asset("assets/images/sun.png"),
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

                      // Planets with centered numbers
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
                            onTap: () => _handlePlanetTap(planet),
                            child: Stack(
                              alignment: Alignment.center,
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
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '$planetNumber',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                          '${planetNumbers[planet.id]} = ${planet.name.tr}',
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
      ),
    );
  }
}