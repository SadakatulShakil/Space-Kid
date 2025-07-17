import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

// lib/features/space_stations/views/space_stations_screen.dart
class SpaceStationsScreen extends StatelessWidget {
  const SpaceStationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Space Stations')),
      body: ListView(
        children: [
          _buildSpaceStation(
            name: 'International Space Station (ISS)',
            description: '''<div style="font-family: Arial, sans-serif;">
  <p>The <strong>International Space Station</strong> is a large spacecraft in orbit around Earth, serving as a space environment research lab.</p>
  
  <h2>Quick Facts</h2>
  <ul>
    <li><strong>Launched:</strong> 1998</li>
    <li><strong>Purpose:</strong> Space research, international cooperation</li>
    <li><strong>Orbit:</strong> Low Earth orbit, approximately 400 km above Earth</li>
    <li><strong>Speed:</strong> 28,000 km/h, completing an orbit every 90 minutes</li>
    <li><strong>Modules:</strong> Includes living quarters, laboratories, and solar arrays</li>
    <li><strong>International Partnership:</strong> Built and operated by NASA, Roscosmos, ESA, JAXA, and CSA</li>
    <li><strong>Crew:</strong> Usually 6 astronauts onboard, rotating every 6 months</li>
  </ul>
  
  <h2>Research Areas</h2>
  <p>Key areas of research include biology, physics, astronomy, and materials science in microgravity.</p>
</div>
''',
            image: 'assets/images/iss.jpg',
              context: context,
              link: 'https://www.nasa.gov/international-space-station/'
          ),
          _buildSpaceStation(
            name: 'Tiangong Space Station',
            description: '''<div style="font-family: Arial, sans-serif;">
  <p>The <strong>Tiangong Space Station</strong> is China's modular space station designed for long-term human operations and scientific research.</p>
  
  <h2>Key Information</h2>
  <ul>
    <li><strong>Launch Date:</strong> April 29, 2021 (Tianhe core module)</li>
    <li><strong>Modular Design:</strong> Comprises multiple modules for various functions.</li>
    <li><strong>Operational Goals:</strong> To support scientific research and technology demonstration.</li>
    <li><strong>International Collaboration:</strong> Aims to foster cooperation in space exploration.</li>
    <li><strong>Expected Completion:</strong> Fully operational by the mid-2020s.</li>
  </ul>

  <h2>Scientific Research Areas</h2>
  <p>Focuses on biology, materials science, astronomy, and space technology.</p>

  <h2>Current Status</h2>
  <p>The Tiangong Space Station is currently being constructed in orbit, with additional modules scheduled for launch to expand its capabilities.</p>
</div>
    ''',
            image: 'assets/images/tiangong.jpg',
              context: context,
              link: 'https://en.wikipedia.org/wiki/Tiangong_space_station'
          ),
          // Add more space stations...
        ],
      ),
    );
  }

  Widget _buildSpaceStation({
    required String name,
    required String description,
    required String image,
    required BuildContext context,
    required String link,
  }) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Html(data: description,),
                const SizedBox(height: 8),
                Text(
                  'Resources',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.link, color: Colors.teal),
                    const SizedBox(width: 8),
                    Expanded(
                      // Ensures the text doesn't overflow
                      child: Text(
                        link,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.indigoAccent),
                        overflow: TextOverflow
                            .ellipsis, // Adds ellipsis (...) for long text
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: link)); // Copy to clipboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied to clipboard: $link')),
                        );
                      },
                      child: const Icon(Icons.copy, color: Colors.white70),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}