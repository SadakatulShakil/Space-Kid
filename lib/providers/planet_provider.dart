import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/planet_model.dart';

class PlanetProvider with ChangeNotifier {
  final List<CelestialBody> _planets = [];

  PlanetProvider() {
    _planets.addAll(_getLocalizedPlanets());
  }

  List<CelestialBody> _getLocalizedPlanets() {
    return [
      CelestialBody(
        id: 'sun',
        name: 'sun_name'.tr,
        description: 'sun_description'.tr,
        imageUrl: 'assets/images/sun.png',
        diameter: 1391000,
        mass: 1.989e30,
        distanceFromSun: 0,
        orbitalPeriod: 0,
        rotationPeriod: 25.38,
        facts: [
          'sun_fact_1'.tr,
          'sun_fact_2'.tr,
          'sun_fact_3'.tr,
          'sun_fact_4'.tr,
          'sun_fact_5'.tr,
        ],
        characteristics: {
          'type': 'sun_type'.tr,
          'atmosphere': 'sun_atmosphere'.tr,
          'surface': 'sun_surface'.tr,
          'magnetic field': 'sun_magnetic_field'.tr,
          'rings': 'sun_rings'.tr,
        },
        orbitRadius: 0,
        rotationSpeed: 0.0,
      ),
      CelestialBody(
        id: 'mercury',
        name: 'mercury_name'.tr,
        description: 'mercury_description'.tr,
        imageUrl: 'assets/images/mercury.png',
        diameter: 4879,
        mass: 3.285e23,
        distanceFromSun: 57.9,
        orbitalPeriod: 88,
        rotationPeriod: 58.6,
        facts: [
          'mercury_fact_1'.tr,
          'mercury_fact_2'.tr,
          'mercury_fact_3'.tr,
          'mercury_fact_4'.tr,
          'mercury_fact_5'.tr,
        ],
        characteristics: {
          'type': 'mercury_type'.tr,
          'atmosphere': 'mercury_atmosphere'.tr,
          'surface': 'mercury_surface'.tr,
          'magnetic field': 'mercury_magnetic_field'.tr,
          'rings': 'mercury_rings'.tr,
        },
        orbitRadius: 50,
        rotationSpeed: 0.08,
      ),
      CelestialBody(
        id: 'venus',
        name: 'venus_name'.tr,
        description: 'venus_description'.tr,
        imageUrl: 'assets/images/venus.png',
        diameter: 12104,
        mass: 4.867e24,
        distanceFromSun: 108.2,
        orbitalPeriod: 225,
        rotationPeriod: -243,
        facts: [
          'venus_fact_1'.tr,
          'venus_fact_2'.tr,
          'venus_fact_3'.tr,
          'venus_fact_4'.tr,
          'venus_fact_5'.tr,
        ],
        characteristics: {
          'type': 'venus_type'.tr,
          'atmosphere': 'venus_atmosphere'.tr,
          'surface': 'venus_surface'.tr,
          'magnetic field': 'venus_magnetic_field'.tr,
          'rings': 'venus_rings'.tr,
        },
        orbitRadius: 70,
        rotationSpeed: 0.07,
      ),
      CelestialBody(
        id: 'earth',
        name: 'earth_name'.tr,
        description: 'earth_description'.tr,
        imageUrl: 'assets/images/earth.png',
        diameter: 12742,
        mass: 5.972e24,
        distanceFromSun: 149.6,
        orbitalPeriod: 365.2,
        rotationPeriod: 1,
        facts: [
          'earth_fact_1'.tr,
          'earth_fact_2'.tr,
          'earth_fact_3'.tr,
          'earth_fact_4'.tr,
          'earth_fact_5'.tr,
        ],
        characteristics: {
          'type': 'earth_type'.tr,
          'atmosphere': 'earth_atmosphere'.tr,
          'surface': 'earth_surface'.tr,
          'magnetic field': 'earth_magnetic_field'.tr,
          'rings': 'earth_rings'.tr,
        },
        orbitRadius: 90,
        rotationSpeed: 0.1,
      ),
      CelestialBody(
        id: 'mars',
        name: 'mars_name'.tr,
        description: 'mars_description'.tr,
        imageUrl: 'assets/images/mars.png',
        diameter: 6779,
        mass: 6.39e23,
        distanceFromSun: 227.9,
        orbitalPeriod: 687,
        rotationPeriod: 1.03,
        facts: [
          'mars_fact_1'.tr,
          'mars_fact_2'.tr,
          'mars_fact_3'.tr,
          'mars_fact_4'.tr,
          'mars_fact_5'.tr,
        ],
        characteristics: {
          'type': 'mars_type'.tr,
          'atmosphere': 'mars_atmosphere'.tr,
          'surface': 'mars_surface'.tr,
          'magnetic field': 'mars_magnetic_field'.tr,
          'rings': 'mars_rings'.tr,
        },
        orbitRadius: 110,
        rotationSpeed: 0.11,
      ),
      CelestialBody(
        id: 'jupiter',
        name: 'jupiter_name'.tr,
        description: 'jupiter_description'.tr,
        imageUrl: 'assets/images/jupiter.png',
        diameter: 139820,
        mass: 1.898e27,
        distanceFromSun: 778.5,
        orbitalPeriod: 4333,
        rotationPeriod: 0.41,
        facts: [
          'jupiter_fact_1'.tr,
          'jupiter_fact_2'.tr,
          'jupiter_fact_3'.tr,
          'jupiter_fact_4'.tr,
          'jupiter_fact_5'.tr,
        ],
        characteristics: {
          'type': 'jupiter_type'.tr,
          'atmosphere': 'jupiter_atmosphere'.tr,
          'surface': 'jupiter_surface'.tr,
          'magnetic field': 'jupiter_magnetic_field'.tr,
          'rings': 'jupiter_rings'.tr,
        },
        orbitRadius: 140,
        rotationSpeed: 0.2,
      ),
      CelestialBody(
        id: 'saturn',
        name: 'saturn_name'.tr,
        description: 'saturn_description'.tr,
        imageUrl: 'assets/images/satrun.png',
        diameter: 116460,
        mass: 5.683e26,
        distanceFromSun: 1434,
        orbitalPeriod: 10759,
        rotationPeriod: 0.45,
        facts: [
          'saturn_fact_1'.tr,
          'saturn_fact_2'.tr,
          'saturn_fact_3'.tr,
          'saturn_fact_4'.tr,
          'saturn_fact_5'.tr,
        ],
        characteristics: {
          'type': 'saturn_type'.tr,
          'atmosphere': 'saturn_atmosphere'.tr,
          'surface': 'saturn_surface'.tr,
          'magnetic field': 'saturn_magnetic_field'.tr,
          'rings': 'saturn_rings'.tr,
        },
        orbitRadius: 170,
        rotationSpeed: 0.18,
      ),
      CelestialBody(
        id: 'uranus',
        name: 'uranus_name'.tr,
        description: 'uranus_description'.tr,
        imageUrl: 'assets/images/urenus.png',
        diameter: 50724,
        mass: 8.681e25,
        distanceFromSun: 2871,
        orbitalPeriod: 30687,
        rotationPeriod: -0.72,
        facts: [
          'uranus_fact_1'.tr,
          'uranus_fact_2'.tr,
          'uranus_fact_3'.tr,
          'uranus_fact_4'.tr,
          'uranus_fact_5'.tr,
        ],
        characteristics: {
          'type': 'uranus_type'.tr,
          'atmosphere': 'uranus_atmosphere'.tr,
          'surface': 'uranus_surface'.tr,
          'magnetic field': 'uranus_magnetic_field'.tr,
          'rings': 'uranus_rings'.tr,
        },
        orbitRadius: 200,
        rotationSpeed: 0.14,
      ),
      CelestialBody(
        id: 'neptune',
        name: 'neptune_name'.tr,
        description: 'neptune_description'.tr,
        imageUrl: 'assets/images/naptune.png',
        diameter: 49244,
        mass: 1.024e26,
        distanceFromSun: 4495,
        orbitalPeriod: 60190,
        rotationPeriod: 0.67,
        facts: [
          'neptune_fact_1'.tr,
          'neptune_fact_2'.tr,
          'neptune_fact_3'.tr,
          'neptune_fact_4'.tr,
          'neptune_fact_5'.tr,
        ],
        characteristics: {
          'type': 'neptune_type'.tr,
          'atmosphere': 'neptune_atmosphere'.tr,
          'surface': 'neptune_surface'.tr,
          'magnetic field': 'neptune_magnetic_field'.tr,
          'rings': 'neptune_rings'.tr,
        },
        orbitRadius: 230,
        rotationSpeed: 0.12,
      ),
    ];
  }

  CelestialBody? _selectedPlanet;
  bool _isLoading = false;

  List<CelestialBody> get planets => _planets;
  CelestialBody? get selectedPlanet => _selectedPlanet;
  bool get isLoading => _isLoading;

  Future<void> selectPlanet(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _selectedPlanet = _planets.firstWhere((planet) => planet.id == id);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  AppSettings settings = AppSettings();

  void updateSettings(AppSettings newSettings) {
    settings = newSettings;
    notifyListeners();
  }
}
