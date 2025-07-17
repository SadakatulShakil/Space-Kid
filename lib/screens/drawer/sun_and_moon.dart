import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/services.dart';

class SunAndMoonScreen extends StatelessWidget {
  const SunAndMoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SUN & MOON')),
      body: ListView(
        children: [
          _buildSpaceStation(
            context: context,
            name: 'About the Sun',
            description: '''<div style="font-family: Arial, sans-serif;">
  
  <h2>Overview</h2>
  <p>The Sun is the star at the center of our Solar System, accounting for 99.86% of its mass. It’s a nearly perfect sphere of hot plasma, essential for life on Earth, and is about 4.6 billion years old.</p>
  
  <h2>Physical Characteristics</h2>
  <ul>
    <li><strong>Diameter:</strong> 1.39 million km</li>
    <li><strong>Mass:</strong> 330,000 times that of Earth</li>
    <li><strong>Temperature:</strong> 5,500°C on the surface, 15 million°C in the core</li>
  </ul>

  <h2>Importance</h2>
  <p>The Sun is crucial for life on Earth, providing energy, driving the climate, and anchoring the Solar System with its gravity.</p>

  <h2>Fun Facts</h2>
  <ul>
    <li>The Sun's light takes 8 minutes to reach Earth.</li>
    <li>Over 1 million Earths could fit inside the Sun.</li>
  </ul>
</div>
''',
            image: 'assets/images/sun_data.jpg',
            link: 'https://en.wikipedia.org/wiki/Sun',
          ),
          _buildSpaceStation(
            context: context,
            name: 'About the Moon',
            description: '''<div style="font-family: Arial, sans-serif;">
  <h2>Overview</h2>
  <p>The Moon is Earth's only natural satellite and the fifth-largest moon in the Solar System. It is about one-quarter the size of Earth and has a profound effect on our planet, influencing tides and stabilizing Earth’s tilt.</p>

  <h2>Physical Characteristics</h2>
  <ul>
    <li><strong>Diameter:</strong> 3,474 km</li>
    <li><strong>Mass:</strong> 1/6th of Earth's mass</li>
    <li><strong>Gravity:</strong> 1/6th of Earth's gravity</li>
    <li><strong>Surface Temperature:</strong> Day: 127°C, Night: -173°C</li>
  </ul>

  <h2>Phases of the Moon</h2>
  <p>The Moon goes through several phases each month, caused by its orbit around Earth and the relative positions of the Sun. The main phases are:</p>
  <ul>
    <li><strong>New Moon:</strong> The Moon is between Earth and the Sun, making it invisible from Earth.</li>
    <li><strong>Full Moon:</strong> The entire face of the Moon is illuminated.</li>
    <li><strong>First and Last Quarters:</strong> Half of the Moon is illuminated.</li>
  </ul>

  <h2>Interesting Facts</h2>
  <ul>
    <li>The Moon is about 384,400 km from Earth.</li>
    <li>Humans first landed on the Moon in 1969 during NASA’s Apollo 11 mission.</li>
    <li>The Moon has no atmosphere, leading to extreme temperatures.</li>
  </ul>
</div>
''',
            image: 'assets/images/moon.jpg',
            link: 'https://en.wikipedia.org/wiki/Moon',
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
    required String link,
    required BuildContext context,
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
                    Expanded( // Ensures the text doesn't overflow
                      child: Text(
                        link,
                        style: const TextStyle(fontSize: 16, color: Colors.indigoAccent),
                        overflow: TextOverflow.ellipsis, // Adds ellipsis (...) for long text
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: link)); // Copy to clipboard
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