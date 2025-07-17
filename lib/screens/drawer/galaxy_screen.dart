import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class GalaxyScreen extends StatelessWidget {
  const GalaxyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Our Galaxy')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/galaxy.jpg'),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'The Milky Way Galaxy',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Html(
                data: """
            <div style="font-family: Arial, sans-serif;">
              <p>The <strong>Milky Way Galaxy</strong> is the galaxy that contains our solar system. It is one of billions of galaxies in the universe.</p>
              
              <h2>1. Structure and Shape</h2>
              <ul>
                <li><strong>Spiral Galaxy:</strong> The Milky Way is classified as a barred spiral galaxy with a disk-like structure and distinct spiral arms.</li>
                <li><strong>Size:</strong> Spans about <em>100,000 light-years</em> in diameter and contains between <em>100 to 400 billion stars</em>.</li>
                <li><strong>Galactic Center:</strong> At its center is a supermassive black hole called <em>Sagittarius A*</em>.</li>
              </ul>

              <h2>2. Location in the Universe</h2>
              <p>The Milky Way is part of the <strong>Local Group</strong> of galaxies, which includes the Andromeda Galaxy and the Triangulum Galaxy.</p>

              <h2>3. Solar System’s Location</h2>
              <p>Our solar system is located in the <em>Orion Arm</em>, about 27,000 light-years from the galactic center.</p>

              <h2>4. Rotation and Movement</h2>
              <ul>
                <li><strong>Galactic Year:</strong> Our solar system takes about <em>225-250 million years</em> to orbit the galaxy's center.</li>
                <li>The galaxy is moving at around <em>600 km/s</em> relative to the cosmic microwave background.</li>
              </ul>

              <h2>5. Components</h2>
              <ul>
                <li><strong>Stars and Planets:</strong> Billions of stars with their own planetary systems exist in the Milky Way.</li>
                <li><strong>Nebulae:</strong> Massive clouds of gas and dust are star-forming regions in the galaxy.</li>
                <li><strong>Dark Matter:</strong> The Milky Way contains a significant amount of invisible dark matter.</li>
              </ul>

              <h2>6. Age</h2>
              <p>The Milky Way is approximately <em>13.6 billion years old</em>, forming shortly after the Big Bang.</p>

              <h2>7. Satellite Galaxies</h2>
              <p>The Milky Way has several smaller <strong>satellite galaxies</strong>, such as the <em>Large Magellanic Cloud (LMC)</em> and <em>Small Magellanic Cloud (SMC)</em>.</p>
            </div>
            """,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Resources',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.link, color: Colors.teal),
                  const SizedBox(width: 8),
                  Expanded( // Ensures the text doesn't overflow
                    child: Text(
                      'https://en.wikipedia.org/wiki/Milky_Way',
                      style: const TextStyle(fontSize: 16, color: Colors.indigoAccent),
                      overflow: TextOverflow.ellipsis, // Adds ellipsis (...) for long text
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: 'https://en.wikipedia.org/wiki/Milky_Way')); // Copy to clipboard
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied to clipboard: https://en.wikipedia.org/wiki/Milky_Way')),
                      );
                    },
                    child: const Icon(Icons.copy, color: Colors.white70),
                  ),
                ],
              ),
            ),
            // Add more galaxy information...
          ],
        ),
      ),
    );
  }
}