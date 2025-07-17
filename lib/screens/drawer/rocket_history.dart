import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class RocketHistoryScreen extends StatelessWidget {
  const RocketHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rocket History')),
      body: ListView(
        children: [
          _buildSpaceStation(
              name: 'V-2 Rocket (1944)',
              description: '''<div style="font-family: Arial, sans-serif;">
  <p>The V-2 rocket, developed by Germany during World War II, was the world's first long-range guided ballistic missile. It marked a significant advancement in rocket technology and laid the foundation for modern rocketry.</p>
  <p><strong>Description:</strong> The V-2 was powered by a liquid-fuel engine and was used for military purposes, targeting cities in Europe. Its development by engineer Wernher von Braun led to the post-war adoption of its technology by both the United States and the Soviet Union.</p>
</div>
''',
              image: 'assets/images/v2_rocket.jpg',
              context: context,
              link: 'https://en.wikipedia.org/wiki/V-2_rocket'
          ),
          _buildSpaceStation(
            name: 'Sputnik 1 (1957)',
            description: '''<div style="font-family: Arial, sans-serif;">
  <p>Launched by the Soviet Union on October 4, 1957, Sputnik 1 was the first artificial satellite to orbit Earth. This event marked the beginning of the space age and initiated the space race between the United States and the Soviet Union.</p>
  <p><strong>Description:</strong> Sputnik 1 was a spherical satellite, about 58 cm in diameter, that emitted radio pulses. Its successful launch shocked the world and prompted significant advancements in space exploration and technology.</p>

</div>
''',
            image: 'assets/images/sputnik.jpg',
              context: context,
              link: 'https://en.wikipedia.org/wiki/Sputnik_1'
          ),

          _buildSpaceStation(
            name: 'Apollo 11 (1969)',
            description: '''<div style="pfont-family: Arial, sans-serif;">
  <p>The Apollo 11 mission, launched on July 16, 1969, successfully landed humans on the Moon for the first time. Astronauts Neil Armstrong and Buzz Aldrin became the first and second humans to walk on the lunar surface, achieving a significant milestone in human space exploration.</p>
  <p><strong>Description:</strong> Apollo 11's lunar module, "Eagle," landed on the Moon's Sea of Tranquility. Armstrong's famous words, "That's one small step for [a] man, one giant leap for mankind," highlighted the mission's historic significance.</p>

</div>
''',
            image: 'assets/images/appolo11.jpg',
              context: context,
              link: 'https://en.wikipedia.org/wiki/Apollo_11'
          ),
          _buildSpaceStation(
            name: 'Space Shuttle (1981)',
            description: '''<div style="pfont-family: Arial, sans-serif;">
  <p>The Space Shuttle program, initiated by NASA in 1981, introduced a reusable spacecraft design that revolutionized space travel. It enabled regular missions to low Earth orbit and facilitated the construction of the International Space Station (ISS).</p>
  <p><strong>Description:</strong> The Space Shuttle fleet, including notable missions like Hubble Space Telescope deployment, significantly contributed to scientific research and international cooperation in space.</p>
  
</div>
''',
            image: 'assets/images/space_sttule.jpg',
              context: context,
              link: 'https://en.wikipedia.org/wiki/STS-1'
          ),
          _buildSpaceStation(
            name: 'Falcon 9 (2010)',
            description: '''<div style="font-family: Arial, sans-serif;">
  <p>Developed by SpaceX, the Falcon 9 rocket made its first successful flight in June 2010. It was the first privately developed liquid-fueled rocket to reach orbit and marked the beginning of the era of commercial spaceflight.</p>
  <p><strong>Description:</strong> Falcon 9's innovative design features a reusable first stage, dramatically reducing launch costs and enabling a new era of commercial space operations, including resupply missions to the ISS.</p>

</div>
''',
            image: 'assets/images/falcon_9.jpg',
              context: context,
              link: 'https://en.wikipedia.org/wiki/List_of_Falcon_9_and_Falcon_Heavy_launches_(2010%E2%80%932019)'
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
                Html(data: description),
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
