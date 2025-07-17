import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class AboutNasaScreen extends StatelessWidget {
  const AboutNasaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About NASA')),
      body: ListView(
        children: [
          _buildSpaceStation(
            name: 'What is NASA?',
            description: '''<div style="font-family: Arial, sans-serif;">
  <p>The <strong>National Aeronautics and Space Administration</strong> (NASA) is an independent agency of the United States federal government, established on July 29, 1958. NASA is responsible for the nation's civilian space program and for aeronautics and aerospace research. Its mission is to drive advances in science, technology, and exploration in air and space, thereby contributing to our understanding of the universe and enhancing the quality of life on Earth.</p>
  <p>Nasa conducts various activities, including:</p>
  <ul>
    <li>Conducting scientific research and technological development in aeronautics and space.</li>
    <li>Exploring celestial bodies, including the Moon, Mars, and beyond.</li>
    <li>Developing and launching spacecraft and missions for scientific exploration.</li>
    <li>Collaborating with international space agencies and private industry.</li>
  </ul>
</div>
''',
            image: 'assets/images/nasa.jpg',
              context: context,
              link: 'https://www.nasa.gov/'
          ),
          _buildSpaceStation(
            name: 'History',
            description: '''<div style="font-family: Arial, sans-serif;">
  <p>NASA was created in response to the Soviet Union's successful launch of <strong>Sputnik 1</strong> on October 4, 1957, which marked the beginning of the space race. The agency was formed to consolidate various existing organizations involved in aeronautics and space research, including the National Advisory Committee for Aeronautics (NACA), which was established in 1915.</p>
  <p>Key historical milestones include:</p>
  <ul>
    <li><strong>Mercury Program (1958-1963):</strong> The first U.S. human spaceflight program, successfully launching astronauts into low Earth orbit.</li>
    <li><strong>Gemini Program (1962-1966):</strong> Focused on space rendezvous, docking, and long-duration flights, paving the way for the Apollo missions.</li>
    <li><strong>Apollo Program (1961-1972):</strong> Aiming to land humans on the Moon, this program culminated in Apollo 11's historic landing on July 20, 1969.</li>
    <li><strong>Space Shuttle Program (1981-2011):</strong> A reusable spacecraft program that enabled missions to low Earth orbit, including the deployment of the Hubble Space Telescope and the construction of the International Space Station (ISS).</li>
    <li><strong>International Space Station (1998-present):</strong> A joint project with multiple space agencies, providing a platform for scientific research and international collaboration in space.</li>
  </ul>
</div>
''',
            image: 'assets/images/history.jpg',
              context: context,
              link: 'https://www.nasa.gov/'
          ),

          _buildSpaceStation(
            name: 'Major Projects',
            description: '''<div style="font-family: Arial, sans-serif;">
  <ul>
    <li>
      <strong>Apollo Program (1961-1972):</strong>
      <p>The Apollo program was a series of missions aimed at landing humans on the Moon and safely returning them to Earth. Apollo 11, launched on July 16, 1969, was the first successful manned lunar landing, with astronauts Neil Armstrong and Buzz Aldrin becoming the first and second humans to walk on the Moon. The program concluded with Apollo 17 in 1972, which was the last manned mission to the Moon.</p>
    </li>
    <li>
      <strong>Space Shuttle Program (1981-2011):</strong>
      <p>The Space Shuttle program represented a major advancement in human spaceflight, featuring a reusable spacecraft capable of carrying astronauts and cargo to and from low Earth orbit. Over 30 years, the Shuttle completed 135 missions, including the deployment of the Hubble Space Telescope, assembly of the ISS, and various scientific research missions. The program concluded with the final flight of Atlantis on July 21, 2011.</p>
    </li>
    <li>
      <strong>Mars Exploration Program:</strong>
      <p>NASA's Mars Exploration Program includes a series of robotic missions to explore the Red Planet. Notable missions include:</p>
      <ul>
        <li><strong>Spirit and Opportunity (2004):</strong> Twin rovers that explored the Martian surface, providing valuable data about the planet's geology and past water presence.</li>
        <li><strong>Curiosity (2012):</strong> A car-sized rover equipped with advanced scientific instruments to investigate the Gale Crater and assess Mars' habitability.</li>
        <li><strong>Perseverance (2021):</strong> Launched to search for signs of ancient life and collect rock samples for potential return to Earth. It also carried the Ingenuity helicopter, which successfully performed powered flights on another planet for the first time.</li>
      </ul>
    </li>
  </ul>
</div>
''',
            image: 'assets/images/projects.jpg',
              context: context,
              link: 'https://www.nasa.gov/'
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