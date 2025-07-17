import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Me')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/about.gif'),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Hello! I’m Sadakatul Ajam Md. Shakil, '
                'a dedicated mobile app developer with over 4 years of '
                'experience specializing in Flutter development. In today’s '
                'digital world, having a robust mobile application '
                'is essential for businesses to engage customers and drive growth. '
                'My mission is to help you bring your app ideas to life through '
                'innovative and high-performance mobile applications tailored to your specific needs.',
              ),
            ),
            // Contact Information Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email
                    Row(
                      children: [
                        const Icon(Icons.email, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'sadakatulshakil94@gmail.com', // Replace with your email
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Space between email and phone number
                    // Phone
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.green),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: '+8801751330394'));
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Copied to clipboard: +8801751330394')));
                          },
                          child: const Text(
                            '+8801751330394', // Replace with your contact number
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Icon(Icons.link, color: Colors.teal),
                        const SizedBox(width: 8),
                        const Text(
                          'https://github.com/SadakatulShakil', // Replace with your contact number
                          style: TextStyle(fontSize: 16, color: Colors.indigoAccent),
                        ),
                      ],
                    ),
                  ]),
            ),
            // Add more galaxy information...
          ],
        ),
      ),
    );
  }
}
