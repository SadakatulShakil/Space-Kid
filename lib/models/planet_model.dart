class CelestialBody {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double diameter; // km
  final double mass; // kg
  final double distanceFromSun; // million km
  final double orbitalPeriod; // Earth days
  final double rotationPeriod; // Earth days
  final List<String> facts;
  final Map<String, dynamic> characteristics;
  final double orbitRadius;
  final double rotationSpeed;

  const CelestialBody({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.diameter,
    required this.mass,
    required this.distanceFromSun,
    required this.orbitalPeriod,
    required this.rotationPeriod,
    required this.facts,
    required this.characteristics,
    required this.orbitRadius,
    required this.rotationSpeed,
  });

  factory CelestialBody.fromJson(Map<String, dynamic> json) {
    return CelestialBody(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      diameter: json['diameter'].toDouble(),
      mass: json['mass'].toDouble(),
      distanceFromSun: json['distanceFromSun'].toDouble(),
      orbitalPeriod: json['orbitalPeriod'].toDouble(),
      rotationPeriod: json['rotationPeriod'].toDouble(),
      facts: List<String>.from(json['facts']),
      characteristics: json['characteristics'],
      orbitRadius: json['orbitRadius'].toDouble(),
      rotationSpeed: json['rotationSpeed'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'diameter': diameter,
      'mass': mass,
      'distanceFromSun': distanceFromSun,
      'orbitalPeriod': orbitalPeriod,
      'rotationPeriod': rotationPeriod,
      'facts': facts,
      'characteristics': characteristics,
      'orbitRadius': orbitRadius,
      'rotationSpeed': rotationSpeed,
    };
  }
}

class AppSettings {
  final bool showOrbits;
  final bool showPlanetNames;
  final bool enableSounds;
  final double animationSpeed;

  const AppSettings({
    this.showOrbits = true,
    this.showPlanetNames = true,
    this.enableSounds = true,
    this.animationSpeed = 1.0,
  });
}