import 'package:flutter/material.dart';

import '../models/planet_model.dart';

class PlanetProvider with ChangeNotifier {
  final List<CelestialBody> _planets = [
    CelestialBody(
      id: 'mercury',
      name: 'Mercury',
      description: 'The smallest and innermost planet in the Solar System. Despite its proximity to the Sun, Mercury is not the hottest planet, but it has the most extreme temperature variations.',
      imageUrl: 'assets/images/mercury.png',
      diameter: 4879,
      mass: 3.285e23,
      distanceFromSun: 57.9,
      orbitalPeriod: 88,
      rotationPeriod: 58.6,
      facts: [
        'Mercury is the fastest planet, orbiting the Sun every 88 Earth days.',
        'The surface temperature varies from -180°C to 430°C.',
        'Mercury has no moons and no substantial atmosphere.',
        'It is the smallest planet in our solar system.',
        'Despite being closest to the Sun, it is not the hottest planet.',
      ],
      characteristics: {
        'type': 'Terrestrial planet',
        'atmosphere': 'Minimal',
        'surface': 'Heavily cratered',
        'magnetic field': 'Weak',
        'rings': 'None',
      },
      orbitRadius: 50,
      rotationSpeed: 0.08,
    ),

    CelestialBody(
      id: 'venus',
      name: 'Venus',
      description: 'Often called Earth\'s sister planet due to their similar size and mass. Venus is the hottest planet in our solar system due to its thick atmosphere and greenhouse effect.',
      imageUrl: 'assets/images/venus.png',
      diameter: 12104,
      mass: 4.867e24,
      distanceFromSun: 108.2,
      orbitalPeriod: 224.7,
      rotationPeriod: -243, // Negative indicates retrograde rotation
      facts: [
        'Venus rotates backwards compared to most other planets.',
        'It is the hottest planet with surface temperatures of about 462°C.',
        'The atmosphere is 96% carbon dioxide, creating a strong greenhouse effect.',
        'Venus has no moons and no rings.',
        'A day on Venus is longer than its year.',
      ],
      characteristics: {
        'type': 'Terrestrial planet',
        'atmosphere': 'Very thick, CO2',
        'surface': 'Volcanic plains',
        'magnetic field': 'Very weak',
        'rings': 'None',
      },
      orbitRadius: 75,
      rotationSpeed: 0.07,
    ),

    CelestialBody(
      id: 'earth',
      name: 'Earth',
      description: 'Our home planet and the only known planet to harbor life. Earth is the third planet from the Sun and the only astronomical object known to harbor life.',
      imageUrl: 'assets/images/earth.png',
      diameter: 12742,
      mass: 5.972e24,
      distanceFromSun: 149.6,
      orbitalPeriod: 365.25,
      rotationPeriod: 1,
      facts: [
        'Earth is the only planet known to have liquid water on its surface.',
        'It is the only planet known to support life.',
        'The atmosphere is 78% nitrogen and 21% oxygen.',
        'Earth has one natural satellite - the Moon.',
        'It is the densest planet in the Solar System.',
      ],
      characteristics: {
        'type': 'Terrestrial planet',
        'atmosphere': 'Nitrogen and Oxygen',
        'surface': '70.8% water, 29.2% land',
        'magnetic field': 'Strong',
        'rings': 'None',
      },
      orbitRadius: 100,
      rotationSpeed: 0.06,
    ),

    CelestialBody(
      id: 'mars',
      name: 'Mars',
      description: 'Known as the Red Planet, Mars is a cold desert world with a thin atmosphere. It has many Earth-like features such as valleys, deserts, and polar ice caps.',
      imageUrl: 'assets/images/mars.png',
      diameter: 6779,
      mass: 6.39e23,
      distanceFromSun: 227.9,
      orbitalPeriod: 687,
      rotationPeriod: 1.03,
      facts: [
        'Mars is home to the largest volcano in the solar system, Olympus Mons.',
        'It has two small moons, Phobos and Deimos.',
        'The red color comes from iron oxide (rust) on its surface.',
        'Mars has the largest dust storms in the solar system.',
        'Evidence suggests liquid water once flowed on the surface.',
      ],
      characteristics: {
        'type': 'Terrestrial planet',
        'atmosphere': 'Thin, CO2',
        'surface': 'Rocky, desert-like',
        'magnetic field': 'Weak',
        'rings': 'None',
      },
      orbitRadius: 125,
      rotationSpeed: 0.05,
    ),

    CelestialBody(
      id: 'jupiter',
      name: 'Jupiter',
      description: 'The largest planet in our solar system, Jupiter is a gas giant with a Great Red Spot that is actually a giant storm. It has a strong magnetic field and numerous moons.',
      imageUrl: 'assets/images/jupiter.png',
      diameter: 139820,
      mass: 1.898e27,
      distanceFromSun: 778.5,
      orbitalPeriod: 4333,
      rotationPeriod: 0.41,
      facts: [
        'Jupiter has the shortest day of any planet.',
        'The Great Red Spot is a giant storm that has lasted over 400 years.',
        'It has at least 79 moons.',
        'Jupiter\'s magnetic field is the strongest of all planets.',
        'It is more than twice as massive as all other planets combined.',
      ],
      characteristics: {
        'type': 'Gas giant',
        'atmosphere': 'Hydrogen and Helium',
        'surface': 'No solid surface',
        'magnetic field': 'Very strong',
        'rings': 'Faint rings',
      },
      orbitRadius: 170,
      rotationSpeed: 0.04,
    ),

    CelestialBody(
      id: 'saturn',
      name: 'Saturn',
      description: 'Famous for its spectacular ring system, Saturn is a gas giant and the second-largest planet in our solar system. It has a unique composition and numerous moons.',
      imageUrl: 'assets/images/satrun.png',
      diameter: 116460,
      mass: 5.683e26,
      distanceFromSun: 1434,
      orbitalPeriod: 10759,
      rotationPeriod: 0.45,
      facts: [
        'Saturn\'s rings are made mostly of ice and rock.',
        'It has at least 82 moons, including Titan, larger than Mercury.',
        'Saturn would float in water if there were a bathtub large enough.',
        'Its average density is less than water.',
        'The rings are only about 10 meters thick on average.',
      ],
      characteristics: {
        'type': 'Gas giant',
        'atmosphere': 'Hydrogen and Helium',
        'surface': 'No solid surface',
        'magnetic field': 'Strong',
        'rings': 'Prominent rings',
      },
      orbitRadius: 215,
      rotationSpeed: 0.03,
    ),

    CelestialBody(
      id: 'uranus',
      name: 'Uranus',
      description: 'An ice giant planet that rotates on its side, Uranus appears to roll along its orbital path. It is the coldest planet despite not being the farthest from the Sun.',
      imageUrl: 'assets/images/urenus.png',
      diameter: 50724,
      mass: 8.681e25,
      distanceFromSun: 2871,
      orbitalPeriod: 30687,
      rotationPeriod: -0.72, // Negative indicates retrograde rotation
      facts: [
        'Uranus rotates on its side, likely due to a massive collision.',
        'It has 27 known moons, named after literary characters.',
        'The atmosphere contains "diamond rain".',
        'It was the first planet discovered using a telescope.',
        'Its blue-green color comes from methane in its atmosphere.',
      ],
      characteristics: {
        'type': 'Ice giant',
        'atmosphere': 'Hydrogen, Helium, Methane',
        'surface': 'No solid surface',
        'magnetic field': 'Irregular',
        'rings': 'Thin rings',
      },
      orbitRadius: 260,
      rotationSpeed: 0.02,
    ),

    CelestialBody(
      id: 'neptune',
      name: 'Neptune',
      description: 'The windiest planet in our solar system, Neptune is a dark, cold world and the most distant of the planets. It has supersonic winds and a dynamic atmosphere.',
      imageUrl: 'assets/images/naptune.png',
      diameter: 49244,
      mass: 1.024e26,
      distanceFromSun: 4495,
      orbitalPeriod: 60190,
      rotationPeriod: 0.67,
      facts: [
        'Neptune has the strongest winds in the solar system, up to 2,100 km/h.',
        'It has 14 known moons, including Triton which orbits backwards.',
        'One Neptune year equals 165 Earth years.',
        'It was discovered through mathematical predictions.',
        'The Great Dark Spot is a storm similar to Jupiter\'s Great Red Spot.',
      ],
      characteristics: {
        'type': 'Ice giant',
        'atmosphere': 'Hydrogen, Helium, Methane',
        'surface': 'No solid surface',
        'magnetic field': 'Strong',
        'rings': 'Faint rings',
      },
      orbitRadius: 305,
      rotationSpeed: 0.01,
    ),

    CelestialBody(
      id: 'sun',
      name: 'Sun',
      description: 'The Sun is the star at the center of the Solar System. It is a nearly perfect sphere of hot plasma, and the most important source of energy for life on Earth.',
      imageUrl: 'assets/images/sun.png', // Make sure you have an image asset for the Sun
      diameter: 1391000, // Diameter in kilometers
      mass: 1.989e30, // Mass in kilograms
      distanceFromSun: 0, // Sun itself is at 0 million km from itself
      orbitalPeriod: 0, // Sun does not orbit around any other object within the solar system
      rotationPeriod: 25.4, // Rotation period in Earth days (near equator)
      facts: [
        'The Sun accounts for about 99.86% of the total mass of the Solar System.',
        'The Sun is composed primarily of hydrogen (about 75%) and helium (about 24%).',
        'Every second, the Sun fuses approximately 600 million tons of hydrogen into helium.',
        'The Sun\'s surface temperature is about 5,500 degrees Celsius (9,932 degrees Fahrenheit).',
        'The Sun is about 4.6 billion years old and is roughly halfway through its main sequence phase.',
      ],
      characteristics: {
        'Surface Temperature': '5,500 °C',
        'Core Temperature': '15 million °C',
        'Luminosity': '3.828 x 10^26 watts',
        'Composition': 'Hydrogen, Helium, Oxygen, Carbon',
        'Age': '4.6 billion years',
      },
      orbitRadius: 0, // No orbit radius since it's the center of the solar system
      rotationSpeed: 7.189e3, // Rotation speed in km/h (approximate value at equator)
    )
  ];

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