import 'dart:math';
import 'package:flutter/material.dart';
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
    'Mercury': 0.0,
    'Venus': pi / 4,
    'Earth': pi / 8,
    'Mars': 3 * pi / 4,
    'Jupiter': pi,
    'Saturn': 5 * pi / 3,
    'Uranus': 3 * pi / 5,
    'Neptune': 7 * pi / 4,
  };

  Map<String, double> getOrbitRadii(Size size) {
    final screenRadius = min(size.width, size.height) / 2 - 50;
    final radiiStep = screenRadius / 5.9;

    return {
      'Mercury': radiiStep * 1,
      'Venus': radiiStep * 2,
      'Earth': radiiStep * 3,
      'Mars': radiiStep * 4,
      'Jupiter': radiiStep * 5,
      'Saturn': radiiStep * 6,
      'Uranus': radiiStep * 7,
      'Neptune': radiiStep * 8,
    };
  }

  double getPlanetSize(String name) {
    switch (name) {
      case 'Jupiter':
        return 60.0;
      case 'Saturn':
        return 75.0;
      case 'Uranus':
        return 55.0;
      case 'Neptune':
        return 50.0;
      case 'Earth':
        return 45.0;
      case 'Venus':
        return 40.0;
      case 'Mars':
        return 40.0;
      case 'Mercury':
        return 35.0;
      default:
        return 35.0;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )
      ..repeat();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePlanetTap(BuildContext context, CelestialBody planet) {
    context.read<PlanetProvider>().selectPlanet(planet.id);
    Navigator.pushNamed(context, '/planet-detail');
  }

  void _handleSunTap(BuildContext context, String id) {
    context.read<PlanetProvider>().selectPlanet(id);
    Navigator.pushNamed(context, '/planet-detail');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanetProvider>(
      builder: (context, provider, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);
            final orbitRadii = getOrbitRadii(size);
            final centerX = size.width / 2;
            final centerY = size.height / 2;

            final planetNames = [
              'Mercury', 'Venus', 'Earth', 'Mars',
              'Jupiter', 'Saturn', 'Uranus', 'Neptune'
            ];

            return Stack(
              children: [
                // Background (Static Stars)
                StarField(),
                // Solar System (with zoom and pan)
                Positioned.fill(
                  child: InteractiveViewer(
                    boundaryMargin: const EdgeInsets.all(double.infinity),
                    minScale: 0.2,
                    maxScale: 5.5,
                    child: Stack(
                      children: [
                        // Sun at the center
                        Positioned(
                          left: centerX - 15,
                          top: centerY - 15,
                          child: GestureDetector(
                            onTap: () => print("clicked sun"),
                            child: Container(
                              width: 30,
                              height: 30,
                              child: Image.asset("assets/images/sun.png"),
                            ),
                          ),
                        ),

                        //Orbit lines with animation
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
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.03),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),

                        // Planets
                        ...provider.planets
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final planet = entry.value;
                          final radius = orbitRadii[planet.name];
                          final planetSize = getPlanetSize(planet.name);

                          if (radius == null) return const SizedBox.shrink();

                          final angle = _controller.value * 2 * pi +
                              initialAngles[planet.name]!;
                          final offsetX = centerX + radius * cos(angle);
                          final offsetY = centerY + radius * sin(angle);

                          return Positioned(
                            left: offsetX - (planetSize / 2),
                            top: offsetY - (planetSize / 2),
                            child: GestureDetector(
                              onTap: () => _handlePlanetTap(context, planet),
                              child: Container(
                                width: planetSize,
                                height: planetSize,
                                padding: const EdgeInsets.all(4),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Hero(
                                        tag: planet.id,
                                        child: Image.asset(
                                          planet.imageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: planetSize * 0.25,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),


                // Legend at the top describing number-planet mapping (Restored)
                Positioned(
                  top: 20,
                  left: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.transparent, // Removed background shade
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: planetNames.asMap().entries.map((entry) {
                        final index = entry.key;
                        final planetName = entry.value;
                        return Text(
                          '${index + 1} = $planetName',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
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
    );
  }
}
