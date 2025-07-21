import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/planet_model.dart';

class PlanetController extends GetxController {
  final currentLocale = Rx<Locale>(const Locale('bn', 'BD'));
  final planets = <CelestialBody>[].obs;
  final _selectedPlanet = Rxn<CelestialBody>();
  final _isLoading = false.obs;
  final settings = Rx<AppSettings>(AppSettings());

  CelestialBody? get selectedPlanet => _selectedPlanet.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _loadPlanets();
    super.onInit();
    ever(currentLocale, (_) => _loadPlanets());
  }

  List<bool> selectedLanguage = [false, true].obs;

  Future changeLanguage(int index) async {
    for (int buttonIndex = 0; buttonIndex < selectedLanguage.length; buttonIndex++) {
      if (buttonIndex == index) {
        selectedLanguage[buttonIndex] = true;
      } else {
        selectedLanguage[buttonIndex] = false;
      }
    }
    if(index == 0) {
      await Get.updateLocale(Locale('en', 'US'));
    } else {
      await Get.updateLocale(Locale('bn', 'BD'));
    }
  }

  void toggleLanguage() {
    print('Current locale: ${currentLocale.value}');
    final newLocale = currentLocale.value.languageCode == 'bn'
        ? const Locale('en', 'US')
        : const Locale('bn', 'BD');
    Get.updateLocale(currentLocale.value);
    planets.refresh();
    print('Switching to: $newLocale');
  }

  void _loadPlanets() {
    planets.assignAll(_getLocalizedPlanets());
  }

  List<CelestialBody> _getLocalizedPlanets() {
    return [
      CelestialBody(
        id: 'sun',
        name: 'sun_name',
        description: 'sun_description',
        imageUrl: 'assets/images/sun.png',
        diameter: 1391000,
        mass: 1.989e30,
        distanceFromSun: 0,
        orbitalPeriod: 0,
        rotationPeriod: 25.38,
        facts: [
          'sun_fact_1'.tr,
          'sun_fact_2',
          'sun_fact_3',
          'sun_fact_4',
          'sun_fact_5',
        ],
        characteristics: {
          'type': 'sun_type',
          'atmosphere': 'sun_atmosphere',
          'surface': 'sun_surface',
          'magnetic field': 'sun_magnetic_field',
          'rings': 'sun_rings',
        },
        orbitRadius: 0,
        rotationSpeed: 0.0,
      ),
      CelestialBody(
        id: 'mercury',
        name: 'mercury_name',
        description: 'mercury_description',
        imageUrl: 'assets/images/mercury.png',
        diameter: 4879,
        mass: 3.285e23,
        distanceFromSun: 57.9,
        orbitalPeriod: 88,
        rotationPeriod: 58.6,
        facts: [
          'mercury_fact_1',
          'mercury_fact_2',
          'mercury_fact_3',
          'mercury_fact_4',
          'mercury_fact_5',
        ],
        characteristics: {
          'type': 'mercury_type',
          'atmosphere': 'mercury_atmosphere',
          'surface': 'mercury_surface',
          'magnetic field': 'mercury_magnetic_field',
          'rings': 'mercury_rings',
        },
        orbitRadius: 50,
        rotationSpeed: 0.08,
      ),
      CelestialBody(
        id: 'venus',
        name: 'venus_name',
        description: 'venus_description',
        imageUrl: 'assets/images/venus.png',
        diameter: 12104,
        mass: 4.867e24,
        distanceFromSun: 108.2,
        orbitalPeriod: 225,
        rotationPeriod: -243,
        facts: [
          'venus_fact_1',
          'venus_fact_2',
          'venus_fact_3',
          'venus_fact_4',
          'venus_fact_5',
        ],
        characteristics: {
          'type': 'venus_type',
          'atmosphere': 'venus_atmosphere',
          'surface': 'venus_surface',
          'magnetic field': 'venus_magnetic_field',
          'rings': 'venus_rings',
        },
        orbitRadius: 70,
        rotationSpeed: 0.07,
      ),
      CelestialBody(
        id: 'earth',
        name: 'earth_name',
        description: 'earth_description',
        imageUrl: 'assets/images/earth.png',
        diameter: 12742,
        mass: 5.972e24,
        distanceFromSun: 149.6,
        orbitalPeriod: 365.2,
        rotationPeriod: 1,
        facts: [
          'earth_fact_1',
          'earth_fact_2',
          'earth_fact_3',
          'earth_fact_4',
          'earth_fact_5',
        ],
        characteristics: {
          'type': 'earth_type',
          'atmosphere': 'earth_atmosphere',
          'surface': 'earth_surface',
          'magnetic field': 'earth_magnetic_field',
          'rings': 'earth_rings',
        },
        orbitRadius: 90,
        rotationSpeed: 0.1,
      ),
      CelestialBody(
        id: 'mars',
        name: 'mars_name',
        description: 'mars_description',
        imageUrl: 'assets/images/mars.png',
        diameter: 6779,
        mass: 6.39e23,
        distanceFromSun: 227.9,
        orbitalPeriod: 687,
        rotationPeriod: 1.03,
        facts: [
          'mars_fact_1',
          'mars_fact_2',
          'mars_fact_3',
          'mars_fact_4',
          'mars_fact_5',
        ],
        characteristics: {
          'type': 'mars_type',
          'atmosphere': 'mars_atmosphere',
          'surface': 'mars_surface',
          'magnetic field': 'mars_magnetic_field',
          'rings': 'mars_rings',
        },
        orbitRadius: 110,
        rotationSpeed: 0.11,
      ),
      CelestialBody(
        id: 'jupiter',
        name: 'jupiter_name',
        description: 'jupiter_description',
        imageUrl: 'assets/images/jupiter.png',
        diameter: 139820,
        mass: 1.898e27,
        distanceFromSun: 778.5,
        orbitalPeriod: 4333,
        rotationPeriod: 0.41,
        facts: [
          'jupiter_fact_1',
          'jupiter_fact_2',
          'jupiter_fact_3',
          'jupiter_fact_4',
          'jupiter_fact_5',
        ],
        characteristics: {
          'type': 'jupiter_type',
          'atmosphere': 'jupiter_atmosphere',
          'surface': 'jupiter_surface',
          'magnetic field': 'jupiter_magnetic_field',
          'rings': 'jupiter_rings',
        },
        orbitRadius: 140,
        rotationSpeed: 0.2,
      ),
      CelestialBody(
        id: 'saturn',
        name: 'saturn_name',
        description: 'saturn_description',
        imageUrl: 'assets/images/satrun.png',
        diameter: 116460,
        mass: 5.683e26,
        distanceFromSun: 1434,
        orbitalPeriod: 10759,
        rotationPeriod: 0.45,
        facts: [
          'saturn_fact_1',
          'saturn_fact_2',
          'saturn_fact_3',
          'saturn_fact_4',
          'saturn_fact_5',
        ],
        characteristics: {
          'type': 'saturn_type',
          'atmosphere': 'saturn_atmosphere',
          'surface': 'saturn_surface',
          'magnetic field': 'saturn_magnetic_field',
          'rings': 'saturn_rings',
        },
        orbitRadius: 170,
        rotationSpeed: 0.18,
      ),
      CelestialBody(
        id: 'uranus',
        name: 'uranus_name',
        description: 'uranus_description',
        imageUrl: 'assets/images/urenus.png',
        diameter: 50724,
        mass: 8.681e25,
        distanceFromSun: 2871,
        orbitalPeriod: 30687,
        rotationPeriod: -0.72,
        facts: [
          'uranus_fact_1',
          'uranus_fact_2',
          'uranus_fact_3',
          'uranus_fact_4',
          'uranus_fact_5',
        ],
        characteristics: {
          'type': 'uranus_type',
          'atmosphere': 'uranus_atmosphere',
          'surface': 'uranus_surface',
          'magnetic field': 'uranus_magnetic_field',
          'rings': 'uranus_rings',
        },
        orbitRadius: 200,
        rotationSpeed: 0.14,
      ),
      CelestialBody(
        id: 'neptune',
        name: 'neptune_name',
        description: 'neptune_description',
        imageUrl: 'assets/images/naptune.png',
        diameter: 49244,
        mass: 1.024e26,
        distanceFromSun: 4495,
        orbitalPeriod: 60190,
        rotationPeriod: 0.67,
        facts: [
          'neptune_fact_1',
          'neptune_fact_2',
          'neptune_fact_3',
          'neptune_fact_4',
          'neptune_fact_5',
        ],
        characteristics: {
          'type': 'neptune_type',
          'atmosphere': 'neptune_atmosphere',
          'surface': 'neptune_surface',
          'magnetic field': 'neptune_magnetic_field',
          'rings': 'neptune_rings',
        },
        orbitRadius: 230,
        rotationSpeed: 0.12,
      ),
    ];
  }

  Future<void> selectPlanet(String id) async {
    _isLoading.value = true;
    try {
      _selectedPlanet.value = planets.firstWhere((planet) => planet.id == id);
    } finally {
      _isLoading.value = false;
    }
  }

  void updateSettings(AppSettings newSettings) {
    settings.value = newSettings;
  }
}
